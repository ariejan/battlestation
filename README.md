# Battle Stations!

[![Build Status](https://secure.travis-ci.org/ariejan/battlestation.png?branch=master)](http://travis-ci.org/ariejan/battlestation)

Battle Station allows you to get your development environment up-and-running *fast*. This is still a work in progress.

## Installation

Install is as a gem

    gem install battlestation

or add it to your Gemfile

    gem "battlestation", require: false

## Usage

In the root of your project create a file named `Battlestation`. This file can define your Battlestation plan.

This is an empty plan:

    Battlestation.plan do
      
    end

When you have your Battlestation file complete, run this from the root of your project:

    $ bundle exec battlestation

### Dependencies

You can specify dependencies your battlestation needs in order to function properly. 

#### Executables

If your project depends on a specific executable, you can verify that file exists and is executable:

    Battlestation.plan do
      dependency :redis do
        executable 'redis-server'
      end
    end

Optionally, you may provide instructions in the event the executable is not found.

    Battlestation.plan do
      dependency :redis do
        executable 'redis-server', resolution: "Install redis from redis.io or `brew install redis`"
      end
    end

If an executable is missing, it will cause a failure.

#### Processes

You can check that a given process is running. If the process is not found, this causes a warning. You can force a failure like this:

    Battlestation.plan do
      dependency :redis do
        process 'redis-server'', force_failure: true
      end
    end

