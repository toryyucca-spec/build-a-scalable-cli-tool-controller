#!/usr/bin/env ruby

require 'optparse'
require 'yaml'

class ScalableCLI
  attr_accessor :config, :commands

  def initialize
    @config = load_config
    @commands = {}
  end

  def load_config
    YAML.load_file('config.yml')
  end

  def add_command(name, description, block)
    @commands[name] = { description: description, block: block }
  end

  def run
    OptionParser.new do |opts|
      opts.banner = "Usage: scalable_cli [options] [command]"

      opts.on("-h", "--help", "Show this help message") do
        puts opts
        exit
      end

      opts.on("-c", "--config FILE", "Specify a config file") do |file|
        @config = YAML.load_file(file)
      end
    end.parse!

    command = ARGV[0]
    if @commands.key?(command)
      @commands[command][:block].call
    else
      puts "Unknown command: #{command}"
      exit 1
    end
  end
end

scalable_cli = ScalableCLI.new

scalable_cli.add_command('start', 'Start the application') do
  puts "Starting application..."
  # Add implementation here
end

scalable_cli.add_command('stop', 'Stop the application') do
  puts "Stopping application..."
  # Add implementation here
end

scalable_cli.run