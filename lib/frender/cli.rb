module Frender
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    version Frender::VERSION

    description "Renders config files from input data in YAML format"

    arg :spec, "Specification of files that should be built"

    on("--stat", "Show git stats after rendering files")
    on("--scope YAML", "Override the scope defined in the specification")

    use_log_level_option

    main do |spec|
      Renderer.new(spec, options)
    end

    go!
  end
end
