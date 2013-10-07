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

  COMPILED_PATH = 'compiled-lectures'

  desc 'rebuild', 'Rebuilds all presentations'
  def rebuild
    empty_directory COMPILED_PATH
    %w(js css images).each do |folder|
      directory "html/#{folder}", "#{COMPILED_PATH}/#{folder}"
    end
    copy_file 'lectures/index.yml', "#{COMPILED_PATH}/index.yml"

    slides.keys.each do |number|
      lecture number
    end
  end

  desc 'watch', 'Fires up an FS listener to rebuld presentations when the source file changes'
  def watch
    Listen.to('lectures') do |modified, added, removed|
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


    create_file "#{COMPILED_PATH}/#{builder.output_filename}", builder.html.force_encoding('BINARY')
    directory "lectures/#{index}", "#{COMPILED_PATH}/#{index}" if File.directory?("lectures/#{index}")
  end

  no_tasks do
    def builder_for(index)
      Builder.new slides[index.to_i]
    end

    def slides
      return @slides if @slides

      @slides = YAML.load_file 'lectures/index.yml'
      @slides.delete_if { |index, attributes| attributes.has_key? 'url' }

      @slides
    end
  end
end
