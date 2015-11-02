require './lib/slides'
require 'listen'

class Thor::Actions::CreateFile
  def force_on_collision?
    true
  end
end

class Default < Thor
  include Thor::Actions
  source_root File.dirname(__FILE__)

  desc 'rebuild', 'Rebuilds all presentations'
  def rebuild
    puts "Rebuilding lectures from #{Slides.lectures_path} (change it by setting RUBY_LECTURES_PATH)"

    empty_directory Slides.compiled_lectures_path
    %w(js css images).each do |folder|
      directory "html/#{folder}", "#{Slides.compiled_lectures_path}/#{folder}"
    end
    copy_file "#{Slides.lectures_path}/index.yml", "#{Slides.compiled_lectures_path}/index.yml"

    slides.keys.each do |number|
      lecture number
    end
  end

  desc 'watch', 'Fires up an FS listener to rebuld presentations when the source file changes.'

  def watch
    puts "Listening for changes in #{Slides.lectures_path} (change it by setting RUBY_LECTURES_PATH)"

    Listen.to(Slides.lectures_path) do |modified, added, removed|
      (modified + added + removed).grep(/(\d+)-[\w\-]+.slim$/) do
        begin
          lecture $1.to_i
        rescue Exception => e
          say_status :failed, "Failed to compile: #{e.class.name}", :red
          say e.message.gsub(/^/, "              ")
        end
      end
    end
  end

  desc 'lecture', 'Rebuilds a single lecture'
  def lecture(index)
    index   = '%02d' % index
    builder = builder_for(index)

    create_file "#{Slides.compiled_lectures_path}/#{builder.output_filename}", builder.html.force_encoding('BINARY')

    lecture_folder = "#{Slides.lectures_path}/#{index}"
    directory lecture_folder, "#{Slides.compiled_lectures_path}/#{index}" if File.directory?(lecture_folder)
  end

  no_tasks do
    def builder_for(index)
      builder_defaults = {
        lectures_path: Slides.lectures_path,
        templates_path: self.class.source_root,
      }

      Builder.new builder_defaults.merge(slides[index.to_i])
    end

    def slides
      return @slides if @slides

      @slides = YAML.load_file "#{Slides.lectures_path}/index.yml"
      @slides.delete_if { |index, attributes| attributes.has_key? 'url' }

      @slides
    end
  end
end
