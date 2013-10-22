class Example < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    html = Code.highlight code
    [:static, html]
  end
end
