# frozen_string_literal: true

module Api
  class NameRecordsController < ApiController
    def update_record
      unless updated_record.authentic?(client_id, client_secret)
        render_error status: 403,
                     message: 'You are not allowed to update this record'
        return
      end

      updated_record.update_attributes!(
        ipv4: params[:ipv4],
        ipv6: params[:ipv6]
      )
      render json: { message: 'Record updated' }, status: :ok
    end

    private

    def updated_record
      @updated_record ||= NameRecord.find_by!(fqdn: params[:fqdn])
    end

    def client_id
      params[:client_id]
    end

    def client_secret
      params[:client_secret]
    end
  end
end
