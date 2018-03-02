# frozen_string_literal: true

class CreateNameRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :name_records do |t|
      t.string :fqdn, null: false, index: { unique: true }, limit: 100
      t.string :client_id, null: false
      t.string :client_secret_hash, null: false
      t.string :ipv4, null: true, limit: 15
      t.string :ipv6, null: true, limit: 39

      t.timestamps
    end
  end
end
