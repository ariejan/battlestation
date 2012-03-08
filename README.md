# Battle Stations!

[![Build Status](https://secure.travis-ci.org/ariejan/battlestation.png?branch=master)](http://travis-ci.org/ariejan/battlestation)

Battle Station allows you to get your development environment up-and-running *fast*. This is still a work in progress.

## Installation

Install is as a gem

    gem install battlestation

It's a good idea to add it to the `:development` group in your `Gemfile` as well, but the idea is that you can run
battlestation right after cloning your repository.

Also, battlestation could take care of running `bundle install` for you.

## Usage

In the root of your project create a file named `Battlestation`. This file defines your Battlestation plan.

You can create tasks or dependencies that will be executed sequencially. Each task is composed of one ore more operations.

Operations include:

 * Checking for an executable file in your path
 * Check if a process is running
 * Run system commands

These are three very basic building blocks, but together they allow you to plan your complete development environment. (We'll be happy to add more, but these'll get you started.)

See [this example](https://github.com/ariejan/battlestation/blob/master/examples/Battlestation) for details.

## Bugs / Feature Requests

Please post them to [Github Issues](https://github.com/ariejan/battlestation/issues).

## Contributing

Feel free to help out. Fork the project, write your specs and code and create a pull request.

## Contributors

  * Ariejan de Vroom <ariejan> - original author

## License

Copyright (c) 2012 Ariejan de Vroom

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
