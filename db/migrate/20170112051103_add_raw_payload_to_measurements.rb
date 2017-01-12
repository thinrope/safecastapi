class AddRawPayloadToMeasurements < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE measurements ADD COLUMN raw_payload JSON NOT NULL DEFAULT \'{}\''
  end

  def down
    execute 'ALTER TABLE measurements DROP COLUMN raw_payload'
  end
end
