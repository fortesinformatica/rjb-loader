# rjb-loader

Rjb (Ruby Java Bridge) loader with before_load and after_load hooks

# Description
When working with multiple gems or several rails initializer files that use Rjb, 
you need to make sure that all java dependencies are set up before running Rjb::load. 
This is necessary because Rjb can only be loaded once.

As an example, you could use rjb-loader to change classpath and java options. 
You can do this by adding a 'before_load' hook to your gem or rails initializer.

The 'after_load' hook, on the other hand, should be used when your code needs to run after Rjb::load. 
For instance, when you need to use java classes.

## Install

```
gem install rjb-loader
```

## Configure

Add `rjb-loader` to your Gemfile:

```ruby
  gem "rjb-loader"
```

For any issues related to the java/ruby integration, please check out: [http://rjb.rubyforge.org/](http://rjb.rubyforge.org/). You will find here plenty tips that might help you to solve your problem.

## Using rjb-loader

Example from [jasper-rails](http://github.com/fortesinformatica/jasper-rails):

```ruby
  ...
  
  RjbLoader.before_load do |config|
  
    # This code changes the JVM classpath, so it has to run BEFORE loading Rjb.
    Dir["#{File.dirname(__FILE__)}/java/*.jar"].each do |path|
      config.classpath << File::PATH_SEPARATOR + File.expand_path(path)
    end
    
    # We can also change java options here, if we want to.
    config.java_options += ['-Xms256M', '-Xmx512M']
    
  end
  
  RjbLoader.after_load do |config|
  
    # This code needs java classes, so it has to run AFTER loading Rjb.
    _Locale = Rjb::import 'java.util.Locale'
    JasperRails.config[:report_params]["REPORT_LOCALE"]    = _Locale.new('en', 'US')
    
  end
  ...
```

## LICENSE

Copyright (C) 2013 Marlus Saraiva

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
