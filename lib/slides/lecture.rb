# encoding: utf-8
class Lecture
  LAYOUT_FILE = 'html/layout.slim'
  MONTHS = %w(януари февруари март април май юни юли август септември октомври ноември декември)

  attr_reader :title, :date, :slug, :slides_html

  def initialize(input, title, date)
    @title = title
    @date  = date
    @slides_html = generate_html input
  end

  def render
    Slim::Template.new(LAYOUT_FILE).render(self)
  end

  def date
    "#{@date.day} #{MONTHS[@date.month.pred]} #{@date.year}"
  end

  private

  def generate_html(input)
    Slim::Template.new { input }.render(SlideHelper.new)
  end
end
