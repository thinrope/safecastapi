class CreateSolarcastPayloads < ActiveRecord::Migration
  def change
    create_table :solarcast_payloads do |t|
      t.references :user, null: false
      t.binary :payload, null: false
      t.timestamps null: false
    end
  end
end
