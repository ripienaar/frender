module Frender
  class Renderer
    include Methadone::CLILogging

    def initialize(spec_file, options={})
      @spec_file = spec_file
      @options = options

      load_spec
      load_scope
    end

    def scope
      Marshal.load(Marshal.dump(@scope))
    end

    def render!
      @spec[:files].each do |file, options|
        mode = options.fetch(:mode, 0644)

        info "Rendering %s with mode %o using template %s" % [file, mode, options[:template]]

        File.open(file, "w") do |f|
          f.puts TemplateWrapper::render(options, scope)
        end

        FileUtils.chmod mode, file
      end

      if @options[:stat]
        puts
        c = "git diff --color --stat %s" % @spec[:files].map{|f,_| f}.join(" ")
        system(c)
      end

      nil
    end

    def load_spec
      raise("Cannot find spec file %s" % @spec_file) unless File.exist?(@spec_file)
      raise("Cannot read spec file %s" % @spec_file) unless File.readable?(@spec_file)

      info "Reading specification file %s" % @spec_file

      @spec = YAML.load(File.read(@spec_file))

      if !@spec[:frender].is_a?(Hash) || @spec[:frender].empty?
        raise "No :frender: found in the spec loaded from %s" % @spec_file
      end

      @spec = @spec[:frender]

      if !@spec[:files].is_a?(Hash)
        raise "No :files: found in the spec loaded from %s" % @spec_file
      end
    end

    def load_scope
      if @scope_file = @options[:scope]
        debug "Using scope file %s from options hash" % @options[:scope]
      else
        debug "Using scope file %s from specification" % @spec[:yaml_scope]
        @scope_file = @spec[:yaml_scope]
      end

      info "Reading scope file %s" % @scope_file

      @scope = YAML.load(File.read(@scope_file))
    end
  end
end
