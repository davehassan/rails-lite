require_relative '../phase6/controller_base'
require_relative './flash'

module Phase9
  class ControllerBase < Phase6::ControllerBase
    attr_reader :flash

    def flash
      @flash ||= Flash.new(session)
    end

    def render_content(content, content_type)
      flash.store_flash(self.session)
      super
    end

    def redirect_to(url)
      flash.store_flash(self.session)
      super
    end
  end

end
