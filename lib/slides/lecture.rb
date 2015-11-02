# encoding: utf-8
class Lecture
  MONTHS = %w(януари февруари март април май юни юли август септември октомври ноември декември)

  attr_reader :title, :date, :slug, :image, :slides_html

  def initialize(input, title, date, image)
    @title = title
    @date  = date
    @image = image
    @slides_html = generate_html input
  end

  def render(layout_file: nil)
    Slim::Template.new(layout_file).render(self)
  end

  def date
    "#{@date.day} #{MONTHS[@date.month.pred]} #{@date.year}"
  end

  private

  def generate_html(input)
    Slim::Template.new { input }.render(SlideHelper.new)
  end
end
