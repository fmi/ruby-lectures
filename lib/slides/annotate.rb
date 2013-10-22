class Annotate < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    code = annotate code
    html = Code.highlight code

    [:static, html]
  end

  private

  def annotate(input)
    input = input.gsub /^(.*) #!$/, '(\1) rescue $!.class # =>'

    output = Rcodetools::XMPFilter.new.annotate(input).join('')

    output = output.gsub /^\((.*)\) rescue \$!\.class # =>\s*(.*)$/, '\1 # error: \2'
    output = output.gsub /# +=> (.*)/, '# \1'
    output
  end
end
