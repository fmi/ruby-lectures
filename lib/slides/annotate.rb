class Annotate < Slim::Filter
  def on_slim_embedded(engine, body)
    code = Slim::CollectText.new.call(body)
    code = annotate code
    html = Code.highlight code

    [:static, html]
  end

  private

  def annotate(input)
    input = input.gsub /^(.*)\n(\s*)#!$/u, '(\1) rescue $!.class \2 # =>'
    input = input.gsub /^(.*) ?#!$/u, '(\1) rescue $!.class # =>'

    # Make sure the XMPFilter class is loaded, because it sets the default
    # encoding for external strings to ASCII-8BIT and we need to revert it to
    # something better, like UTF-8.
    Rcodetools::XMPFilter
    Encoding.default_external = 'UTF-8'

    output = Rcodetools::XMPFilter.new(
      warnings: false,
      # For multiline results, max line width to allow before word wrapping
      # will occur. Results are treated as multiline if the annotation marker
      # appears on a newline by itself (optionally preceeded by whitespace).
      width: 80
    ).annotate(input).join('')

    output = output.gsub /^\((.*)\) rescue \$!\.class (\s*) # =>\s*(.*)$/u, "\\1\n\\2# => error: \\3"
    output = output.gsub /^\((.*)\) rescue \$!\.class # =>\s*(.*)$/u, '\1# => error: \2'
    output
  end
end
