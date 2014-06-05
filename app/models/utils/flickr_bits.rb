module Utils
  class FlickrBits

    def initialize
      FlickRaw.api_key="a5f902abaf22726ae424182bdb15df85"
      FlickRaw.shared_secret="43a3f1faf84bc0d8"
    end

    def get_flickr
      flickr
    end

    def get_photo_id url
      photo_id = nil
      begin
        if /^http:\/\/flic.kr\/p\/(.*)/ === url
          /^http:\/\/flic.kr\/p\/(.*)/ =~ url
          base58_coded = $1
          photo_id = Base58.decode base58_coded
        elsif /^http:\/\/www\.flickr\.com\/photos\/.*\/(\d+)\// === url
          /^http:\/\/www\.flickr\.com\/photos\/.*\/(\d+)\// =~ url
          photo_id = $1
        end
      rescue Exception => e
        photo_id = nil
      end
      return photo_id
    end

    def get_medium_image photo_id
      p = get_flickr.photos.getInfo :photo_id => photo_id
      medium_img = "http://farm#{p.farm}.staticflickr.com/#{p.server}/#{photo_id}_#{p.secret}_z.jpg"
          #http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
      return medium_img
    end
    #http://flic.kr/p/b8B5ot
    #http://www.flickr.com/photos/bonbontraveltipscom/6640162183/
  end
end