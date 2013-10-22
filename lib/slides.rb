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
