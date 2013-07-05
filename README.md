# rjb-loader

Rjb (Ruby Java Bridge) loader with before_load and after_load hooks

# Description
When working with multiple gems or several rails initializer files that use Rjb, 
you need to make sure that java dependencies of each implementation 
get all set up before running Rjb::load. This is necessary because Rjb can only be loaded once.

You can use rjb-loader to change classpath and java options, by adding 'before_load' to your gem or rails initializer.

The 'after_load' hook can be used when your code needs an already loaded Rjb. 
For instance, when you need to import and use the java classes.

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

TODO

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
