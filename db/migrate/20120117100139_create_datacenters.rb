class CreateDatacenters < ActiveRecord::Migration
  def change
    create_table :datacenters do |t|
      t.string :name
      t.integer :hosts

      t.timestamps
    end
  end
end
