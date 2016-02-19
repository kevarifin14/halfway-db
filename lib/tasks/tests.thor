require 'English'
require 'open3'

# Run all tests as we would on CI
class Tests < Thor
  default_task :check

  COMMANDS = {
    'rubocop' => 'rubocop',
    'rspec' => 'bundle exec rspec',
  }

  desc :check, 'run all CI tasks'
  def check
    exit 1 unless command_processes.all?(&:success?)
  end

  private

  def command_processes
    COMMANDS.values.map { |command| process_for_command(command) }
  end

  def process_for_command(command)
    Open3.pipeline("#{command}").first
  end
end
