# frozen_string_literal: true

# Simple wrapper around nsupdate
# TODO: detect errors
class NameServiceClient
  class << self
    def connect(key_file)
      raise ArgumentError, 'Block expected' unless block_given?

      client = new(key_file)
      yield client
      client.send
      client.quit
    end
  end

  def initialize(key_file)
    @nsupdate = IO.popen(['nsupdate', '-k', key_file], 'r+')
  end

  def add(fqdn, record_type, ttl, value)
    @nsupdate.puts "update add #{fqdn} #{ttl} #{record_type} #{value}"
  end

  def delete(fqdn, record_type)
    @nsupdate.puts "update delete #{fqdn} #{record_type}"
  end

  def send
    @nsupdate.puts 'send'
  end

  def quit
    @nsupdate.puts 'quit'
    Process.wait(@nsupdate.pid)
  end
end
