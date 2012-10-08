class SlideHelper
  def h(html)
    Temple::Utils.escape_html html
  end

  def slide(title, subtitle = nil)
    output = ''
    output << "<section>\n"
    output << '<hgroup>'
    output << "<h1>#{h title}</h1>"
    output << "<h2>#{h subtitle}</h2>" unless subtitle.nil?
    output << "</hgroup>\n"
    output << yield
    output << "</section>\n"
    output
  end

  def github_repo(repo)
    %{<a href="http://github.com/#{repo}">#{repo}</a>}
  end
end

