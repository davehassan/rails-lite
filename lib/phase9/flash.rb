require 'json'
require 'webrick'
require_relative '../phase4/session'

module Phase9
  class Flash
    attr_reader :now

    def initialize(session)
      @now = session["flash"]
      @now ||= {}
      @flash = {}
    end

    def [](key)
      @flash[key]
    end

    def []=(key, val)
      @flash[key] = val
    end

    def each(&prc)
      @flash.merge(@now).each(&prc)
    end


    def store_flash(session)
      session["flash"] = @flash
    end

  end

end
