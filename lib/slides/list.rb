class List < Slim::Filter
  class Line
    def initialize(line)
      @line = line
    end

    def render
      extract_verbatim_code_blocks
      convert_double_dash_to_mdash
      parse_github_links
      parse_markdown_links
      inject_verbatim_code_blocks

      @line
    end

    private

    def convert_double_dash_to_mdash
      @line = @line.gsub('--', '&mdash;')
    end

    def parse_github_links
      @line = @line.gsub(/\[github:([^\]]*?)\]/, '<a href="http://github.com/\1">\1</a>')
    end

    def parse_markdown_links
      @line = @line.gsub(/\[([^\]]+)\]\((\S+?)\)/, '<a href="\2">\1</a>')
    end

    def extract_verbatim_code_blocks
      @verbatim_code_blocks = {}

      @line = @line.gsub(/`(.*?)`/) do |match|
        code = match[1...-1]
        slug = "<CODE_BLOCK_#{@verbatim_code_blocks.size}_PLACEHOLDER>"

        @verbatim_code_blocks[slug] = "<code>#{h code}</code>"

        slug
      end
    end

    def inject_verbatim_code_blocks
      @verbatim_code_blocks.each do |slug, code|
        @line = @line.gsub(slug, code)
      end
    end

    def h(html)
      Temple::Utils.escape_html html
    end
  end

  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    items = code.lines.map do |line|
      %{<li class="action">#{Line.new(line).render}</li>}
    end
    html = "<ul>#{items.join}</ul>"
    [:static, html]
  end
end
