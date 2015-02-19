module Frender
  class TemplateWrapper
    include Methadone::CLILogging

    def self.render(options, scope, outfile=nil)
      if !File.exist?(options[:template]) && !File.readable?(options[:template])
        raise("Cannot render %s, template %s does not exist or is not readable" % [outfile, options[:template]])
      end

      content = TemplateWrapper.new.render_partial(options[:template], scope)

      if outfile
        info "Rendering file %s using template %s" % [outfile, options[:template]]
        File.open(outfile, "w") {|f| f.puts content}
      else
        info "Rendering using template %s" % options[:template]
      end

      content
    end

    def render_partial(template, scope)
      Tilt.new(template, :trim => "-").render(TemplateWrapper.new, scope)
    end
  end
end
