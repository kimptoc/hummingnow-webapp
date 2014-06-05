module Utils
  class BitlyBits

    def initialize
      Bitly.use_api_version_3
      @bitly = Bitly.new("kimptoc", "R_12bb9a9dffd4afc9befa843a12958f86")
    end

    def bitly
      @bitly
    end

    def expands(url_array, url_expansion_map)
      url_expansions = @bitly.expand url_array
      if url_expansions.is_a? [].class
        url_expansions.each do |exp|
          url_expansion_map[exp.short_url] = exp.long_url
        end
      else
        exp = url_expansions
        url_expansion_map[exp.short_url] = exp.long_url
      end
    end
  end
end