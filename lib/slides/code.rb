class Code
  def self.highlight(code)
    Pygments.highlight(code, lexer: :ruby)
  end
end
