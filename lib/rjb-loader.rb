#
# Copyright (C) 2013 Marlus Saraiva
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "rjb-loader/version"
require "rjb"
require "rails"

module RjbLoader

  class Config
    attr_accessor :classpath
    attr_accessor :java_options
  end
  
  class << self
    attr_accessor :before_load_blocks
    attr_accessor :after_load_blocks
    attr_accessor :config
  end
  
  self.before_load_blocks = []
  self.after_load_blocks  = []
  self.config                   = Config.new
  self.config.classpath         = '.'
  self.config.java_options      = ['-Djava.awt.headless=true','-Xms128M', '-Xmx256M']
  
  def self.before_load &block
    self.before_load_blocks << block 
  end
  
  def self.after_load &block
    self.after_load_blocks << block 
  end
  
  def self.init    
    before_load_blocks.each do |block|
      block.call(config)
    end

    if Rjb.loaded?
      ::Rails.logger.error "Rjb already loaded! RjbLoader configuration options like 'config.classpath' and 'config.java_options' will not apply."
    else
      Rjb::load( config.classpath, config.java_options )
    end
    
    after_load_blocks.each do |block|
      block.call(config)
    end
  end

  class Railtie < Rails::Railtie
    config.after_initialize do
      RjbLoader.init
    end
  end
  
end
