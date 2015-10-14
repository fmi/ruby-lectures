class Annotate < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    code = annotate code
    html = Code.highlight code

    [:static, html]
  end

  private

  def annotate(input)
    input = input.gsub /^(.*) #!$/u, '(\1) rescue $!.class # =>'

    # Make sure the XMPFilter class is loaded, because it sets the default
    # encoding for external strings to ASCII-8BIT and we need to revert it to
    # something better, like UTF-8.
    Rcodetools::XMPFilter
    Encoding.default_external = 'UTF-8'

    output = Rcodetools::XMPFilter.new(warnings: false).annotate(input).join('')

    output = output.gsub /^\((.*)\) rescue \$!\.class # =>\s*(.*)$/u, '\1 # => error: \2'
    output = output.gsub /# +=> (.*)/u, '# => \1'
    output
  end
end
