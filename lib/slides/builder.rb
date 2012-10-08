class Builder
  attr_accessor :title, :date, :slug

  def initialize(attributes)
    attributes.each do |key, value|
      send "#{key}=", value
    end
  end

  def html
    input   = File.read source_file
    lecture = Lecture.new input, title, date

    lecture.render
  end

  def output_filename
    "#@slug.html"
  end

  private

  def source_file
    "lectures/#@slug.slim"
  end
end
