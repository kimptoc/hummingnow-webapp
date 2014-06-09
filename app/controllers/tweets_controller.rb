class TweetsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:public, :phoenix_search]

  before_filter :check_auth_no_nickname, :except => [:user, :public, :phoenix_search]
  before_filter :get_nickname

  respond_to :json

  def get_nickname
    @nickname = params[:nickname]
    Loggr::Events.create().text("tweets_controller.#{params[:action]}:#{@nickname}").post() unless @nickname.present?
  end

  def tweet
    msg = params[:tweet]
    original_tweet_id = params[:original_tweet_id]

    options = {}
    options[:in_reply_to_status_id]=original_tweet_id if original_tweet_id.present?

    result = current_user.twitter(@nickname).update(msg, options)

    Rails.logger.info result

    response = {:tweet_status => "ok"}

    #respond_with response
    #render response
    #render :status => 200
    respond_to do |format|
        format.json { render :json => response}
      end
  end

  def retweet
    original_tweet_id = params[:original_tweet_id]

    result = current_user.twitter(@nickname).retweet(original_tweet_id)

    Rails.logger.info result

    response = {:tweet_status => "ok"}

    respond_to do |format|
      format.json { render :json => response}
    end
  end

  def index
    Rails.logger.debug "Tweets::index"
    twitter_wrapper { |opts| current_user.twitter(@nickname).home_timeline(opts) }
  end

  def mentions
    twitter_wrapper { |opts| current_user.twitter(@nickname).mentions(opts) }
  end

  def mine
    twitter_wrapper { |opts| current_user.twitter(@nickname).user_timeline(opts) }
  end

  def get_twitter
    if current_user
      twitter_conn = current_user.twitter(@nickname)
    end
    if twitter_conn.nil?
      twitter_conn = User.twitter_noauth
    end
    Rails.logger.error "No twitter conn found!" if twitter_conn.nil?
    return twitter_conn
  end

  def user
    twitter_wrapper { |opts| get_twitter.user_timeline(params[:screen_name],opts) }
  end

  def dm
    twitter_wrapper([], :sender) { |opts| current_user.twitter(@nickname).direct_messages(opts) }
  end

  def list
    list_id = params[:list_id]
    Rails.logger.debug "Showing list:#{list_id}"
    twitter_wrapper { |opts| current_user.twitter(@nickname).list_timeline(list_id.to_i, opts) }
  end

  def public
    statuses = []
    TweetStream::Client.new.sample do |status, client|
      statuses << status
      client.stop if statuses.size >= 200
    end
    # twitter_wrapper { |opts| get_twitter.public_timeline(opts) }
    twitter_wrapper { |opts| statuses }
  end

  def phoenix_search
    query = params[:query]
    twitter_wrapper { |opts| opts[:result_type] = 'mixed'; Rails.logger.debug opts.inspect; get_twitter.search(query, opts) }
    # twitter_wrapper { |opts| opts[:result_type] = 'popular'; puts opts.inspect; get_twitter.search(query, opts) }
  end

  def bitly_expansions(bitly, url_expansion_queue, url_expansions)
    Rails.logger.debug "expanding #{url_expansion_queue.length} bitly items"
    #url_expansion_queue.each do |u|
    #  Rails.logger.debug "expanding:#{u}"
    #end
    bitly.expands url_expansion_queue, url_expansions
    url_expansion_queue.clear
  end

  def entity_processor twitter_entities
    twitter_entities.each do |grouping, entities|
      entities.each do |entity|
        if entity.class == {}.class
          short_url = entity[:url]
          if short_url.present?
            long_url = entity[:media_url_https]
            long_url = entity[:media_url] unless long_url.present?
            long_url = entity[:expanded_url] unless long_url.present?
            yield(short_url, long_url)
            #long_url = url_expansions[long_url] if url_expansions[long_url].present?
            #Rails.logger.debug "entify2:#{id}:#{short_url}[#{long_url}]"
            #twitter_text.gsub! short_url, long_url if long_url.present? and short_url.present?
          end
        end
      end
    end
  end

  def entify twitter_text, twitter_entities, url_expansions, id
    return twitter_text unless twitter_entities.present?
    entity_processor twitter_entities do |short_url, long_url|
      long_url = url_expansions[long_url] if url_expansions[long_url].present?
      Rails.logger.debug "entify2:#{id}:#{short_url}[#{long_url}]"
      twitter_text.gsub! short_url, long_url if long_url.present? and short_url.present?
    end
    twitter_text
  end

  def expand_bitly_urls(tweets, url_expansions)
    bitly = Utils::BitlyBits.new
    url_expansion_queue = []
    tweets.each do |tw|
      twitter_entities = tw.attrs[:entities] || []
      entity_processor twitter_entities do |short_url, long_url|
        Rails.logger.debug "entify:#{tw.id}:#{short_url}[#{long_url}]"
        if long_url.present?
          if /^http:\/\/bit\.ly/ === long_url or /^http:\/\/bitly\.com/ === long_url
            #Rails.logger.debug "bitly:#{long_url}"
            url_expansion_queue << long_url unless url_expansions[long_url].present? or url_expansion_queue.include? long_url
            if url_expansion_queue.length >= 15
              bitly_expansions(bitly, url_expansion_queue, url_expansions)
            end
          else
            url_expansions[long_url] = long_url
          end
        end
      end
        #twitter_entities.each do |grouping, entities|
      #  entities.each do |entity|
      #    if entity.class == {}.class
      #      short_url = entity[:url]
      #      if short_url.present?
      #        long_url = entity[:media_url_https]
      #        long_url = entity[:media_url] unless long_url.present?
      #        long_url = entity[:expanded_url] unless long_url.present?
      #        Rails.logger.debug "entify:#{tw.id}:#{short_url}[#{long_url}]"
      #        if long_url.present?
      #          if /^http:\/\/bit\.ly/ === long_url or /^http:\/\/bitly\.com/ === long_url
      #            #Rails.logger.debug "bitly:#{long_url}"
      #            url_expansion_queue << long_url unless url_expansions[long_url].present? or url_expansion_queue.include? long_url
      #            if url_expansion_queue.length >= 15
      #              bitly_expansions(bitly, url_expansion_queue, url_expansions)
      #            end
      #          else
      #            url_expansions[long_url] = long_url
      #          end
      #        end
      #      end
      #    end
      #  end
      #end
    end
    if url_expansion_queue.length > 0
      bitly_expansions(bitly, url_expansion_queue, url_expansions)
    end
    url_expansions.each do |k, v|
      Rails.logger.debug "Expanded:#{k} = #{v}"
    end
  end

  def expand_flickr_urls url_map
    flickr = Utils::FlickrBits.new
    url_map.each do |orig, url|
      begin
        photo_id = flickr.get_photo_id url
        if photo_id.present?
          url_map[orig] = flickr.get_medium_image photo_id
          Rails.logger.debug "flickr:#{url} = #{url_map[orig]}"
        end
      rescue Exception => e
        Rails.logger.debug "flickr pic error:#{url}"
      end
    end
  end

  def twitter_wrapper(optional_attrs = [:favorited?,:retweeted?], user_method = :user)
    tweets_hash = []

    twitter_opts = {}
    twitter_opts[:count] = 200
    twitter_opts[:since_id] = params[:since_id].to_i if params[:since_id].present?
    twitter_opts[:include_entities] = true
    tweets = yield(twitter_opts)

    url_expansions = {}
    expand_bitly_urls(tweets, url_expansions)
    expand_flickr_urls(url_expansions)

    tweets.take(200).each do |tw|
      #Rails.logger.debug "#{tw.id} ? #{twitter_opts[:since_id]}"
      if twitter_opts[:since_id].nil? or tw.id != twitter_opts[:since_id]
        tweet_hash = {}

        user = tw.send(user_method)
        tweet_hash[:name] = user.name
        tweet_hash[:screen_name] = user.screen_name
        tweet_hash[:profile_image_url] = user.profile_image_url.to_s

        tweet_hash[:id_str] = tw.id.to_s
        tweet_hash[:created_at] = tw.created_at
        tweet_hash[:sort_time] = tw.created_at.to_time.to_i
        tweet_hash[:text] = entify tw.text.dup, tw.attrs[:entities], url_expansions, tw.id
        optional_attrs.each {|a| tweet_hash[a] = tw.send(a) }
        tweets_hash << tweet_hash
      else
        Rails.logger.debug "got tweet matching the since_id" if twitter_opts[:since_id].present?
      end
    end

    Rails.logger.info "tweets returned:#{tweets_hash.size}"

    respond_with tweets_hash
  end

end