class List < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    items = code.lines.map do |line|
      line = line.gsub(/`(.*?)`/, '<code>\1</code>')
      line = line.gsub('--', '&mdash;')
      line = line.gsub(/\[github:([^\]]*?)\]/, '<a href="http://github.com/\1">\1</a>')
      line = line.gsub(/\[([^\]]+)\]\((\S+?)\)/, '<a href="\2">\1</a>')
      %{<li class="action">#{line}</li>}
    end
    html = "<ul>#{items.join}</ul>"
    [:static, html]
  end
end
