class Builder
  attr_accessor :title, :date, :slug, :image, :lectures_path, :templates_path

  def initialize(attributes)
    attributes.each do |key, value|
      send "#{key}=", value
    end
  end

  def html
    input   = File.read source_file
    lecture = Lecture.new input, title, date, image

    lecture.render(layout_file: "#{templates_path}/html/layout.slim")
  end

  def output_filename
    "#@slug.html"
  end

  private

  def source_file
    "#{lectures_path}/#@slug.slim"
  end
end
