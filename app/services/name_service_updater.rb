# frozen_string_literal: true

class NameServiceUpdater
  RECORD_TTL = 60

  class << self
    def sync(name_record)
      NameServiceClient.connect(Rails.application.config.nsupdate_key) do |c|
        c.delete(name_record.fqdn, 'A')
        c.add(name_record.fqdn, 'A', RECORD_TTL, name_record.ipv4) if name_record.ipv4.present?

        c.delete(name_record.fqdn, 'AAAA')
        c.add(name_record.fqdn, 'AAAA', RECORD_TTL, name_record.ipv6) if name_record.ipv6.present?
      end
    end
  end
end
