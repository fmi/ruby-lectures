require './lib/slides'
require 'guard'

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
    empty_directory 'compiled'
    %w(js css images).each do |folder|
      directory "html/#{folder}", "compiled/#{folder}"
    end
    copy_file 'lectures/index.yml', 'compiled/index.yml'

    slides.keys.each do |number|
      lecture number
    end
  end

  desc 'watch', 'Fires up guard to rebuld presentations on demand'
  def watch
    listener = Guard::Listener.select_and_init
    listener.on_change do |files|
      files.grep(/lectures\/(\d+)-/) do
        begin
          lecture $1.to_i
          `say Done. 2>/dev/null || echo Done.`
        rescue Exception => e
          `say Error. 2>/dev/null || echo Error:`
          say_status :failed, "Failed to compile: #{e.class.name}", :red
          say e.message.gsub(/^/, "              ")
        end
      end
    end
    listener.start
  end

  desc 'lecture', 'Rebuilds a single lecture'
  def lecture(index)
    builder = builder_for(index)

    create_file "compiled/#{builder.output_filename}", builder.html.force_encoding('BINARY')
    directory "lectures/#{index}", "compiled/#{index}" if File.directory?("lectures/#{index}")
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
