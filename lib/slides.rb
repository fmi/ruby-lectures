require 'rubygems'
require 'slim'
require 'yaml'
require 'pygments'
require 'fileutils'
require 'rcodetools/xmpfilter'

$:.unshift File.dirname(__FILE__) + '/slides'

autoload :Example,     'example'
autoload :Annotate,    'annotate'
autoload :List,        'list'
autoload :SlideHelper, 'slide_helper'
autoload :Lecture,     'lecture'
autoload :Builder,     'builder'
autoload :Code,        'code'

Slim::Engine.default_options[:disable_escape] = true

Slim::EmbeddedEngine.register :example, Example
Slim::EmbeddedEngine.register :annotate, Annotate
Slim::EmbeddedEngine.register :list, List

module Slides
  def self.lectures_path
    @lectures_path ||= File.realpath(
      ENV['RUBY_LECTURES_PATH'] || File.dirname(File.dirname(__FILE__)) + '/lectures'
    )
  end

  def self.compiled_lectures_path
    @compiled_lectures_path ||=
      ENV['RUBY_COMPILED_LECTURES_PATH'] || File.dirname(lectures_path) + '/compiled-lectures'
  end
end
