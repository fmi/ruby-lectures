class Text < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    html = Code.highlight code, lexer: :text
    [:static, html]
  end
end
