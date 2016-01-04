class Code
  def self.highlight(code, lexer: :ruby)
    Pygments.highlight(code, lexer: lexer)
  end
end
