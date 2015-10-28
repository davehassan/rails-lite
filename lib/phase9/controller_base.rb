require_relative '../phase6/controller_base'
require_relative './flash'

module Phase9
  class ControllerBase < Phase6::ControllerBase
    attr_reader :flash

    def flash
      @flash ||= Flash.new(session)
      @flash.store_flash
    end
  end

end
