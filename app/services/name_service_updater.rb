# frozen_string_literal: true

class NameServiceUpdater
  RECORD_TTL = 60

  class << self
    def sync(name_record)
      NameServiceClient.connect(Rails.application.config.nsupdate_key) do |c|
        c.replace(name_record.fqdn, 'A', RECORD_TTL, name_record.ipv4)
        c.replace(name_record.fqdn, 'AAAA', RECORD_TTL, name_record.ipv6)
      end
    end
  end
end
