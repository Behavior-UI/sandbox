require 'redcarpet'

module SandboxHelper

  #
  # If the path is found (a path to a markdown file), the file is rendered to the browser
  # as HTML and this method returns `true`; else `false`
  # @param path [String] Path, relative to the application root, of the markdown file.
  #
  # @return [Boolean] `true` if the markdown file was found and was rendered.
  def render_markdown(path)
    if File.exists?(path)
      @page_title = path.split('/').last.gsub("_", " ").gsub('.md', '').titleize
      render text: read_markdown(path), layout: true
      return true
    else
      return false
    end
  end

  # Reads a markdown file into HTML and returns it.
  # @param  path [String] The location, from the rails root, of the file to read
  #
  # Note: removes un-parsed links and anchor tags ([foo][] and #{foo})
  #
  # @return [String] The HTML rendered.
  def read_markdown(path)
    if Rails.env.production?
      return "Document not found." unless File.exists?(Rails.root.join(path))
    else
      return "File not found: #{Rails.root.join(path)}" unless File.exists?(Rails.root.join(path))
    end
    renderer = Redcarpet::Render::HTML.new
    redcarpet = Redcarpet::Markdown.new(renderer)
    parsed = ERB.new(File.read(Rails.root.join(path))).result(binding)
    html = redcarpet.render(parsed)
    # remove [foo][] and {#foo} - unresolved links and anchors
    html.gsub(/\[(.*?)\]\[\]/, '\1').gsub(/\{\#.*?\}/, '')
  end

  def read_markdown_from_sandbox(path)
    raise "Files must be in the sandbox project" if path.include?('..')
    read_markdown(BOWER_ROOT + path)
  end

  #
  # Parses an html.erb file or markdown file and returns the Nokogiri object to read it.
  # @param path [String] The path to the file *without* a file extension.
  #
  # @return [type] [description]
  def read_html(path)
    if File.exists?("#{SANDBOX_DOCS_ROOT}#{path}.md")
      body = read_markdown("#{SANDBOX_DOCS_ROOT}#{path}.md")
    elsif File.exists?("#{SANDBOX_DOCS_ROOT}#{path}.html.erb")
      # go up from app/views
      body = render_to_string(:template => "../../#{SANDBOX_DOCS_ROOT}#{path}.html.erb")
    else
      return "File not found: #{path}" unless File.exists?(Rails.root.join(path))
    end

    Nokogiri::HTML(body)
  end

end
