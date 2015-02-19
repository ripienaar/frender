module Frender
  class TemplateWrapper
    include Methadone::CLILogging

    def self.render(options, scope)
      if !File.exist?(options[:template]) && !File.readable?(options[:template])
        raise("Cannot render %s, template %s does not exist or is not readable" % [outfile, options[:template]])
      end

      TemplateWrapper.new.render_partial(options[:template], scope)
    end

    def render_partial(template, scope)
      Tilt.new(template, :trim => "-").render(TemplateWrapper.new, scope)
    end
  end
end
