class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :instanceId
      t.string :imageId
      t.string :instanceType
      t.string :architecture
      t.string :rootDeviceType
      t.string :rootDeviceName

      t.timestamps
    end
  end
end
