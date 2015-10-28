require 'json'
require 'webrick'

module Phase9
  class Flash

    def initialize(req)
      req.cookies.each do |cookie|
        if cookie.name == '_rails_lite_app' && cookie.path == '/'
          @value = JSON.parse(cookie.value)
        end
      end
    end

    def [](key)
      @value[key]
    end

    def []=(key, val)
      @value[key] = val
    end

  end

end
