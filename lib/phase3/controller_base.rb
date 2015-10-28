require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller_name = self.class.to_s.underscore
      template_path = "views/#{controller_name}/#{template_name}.html.erb"
      file_contents = File.read(template_path)
      content = ERB.new(file_contents).result(binding)
      render_content(content, 'text/html')
    end
  end
end
