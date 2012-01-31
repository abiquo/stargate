class CreateDatacenters < ActiveRecord::Migration
  def change
    create_table :datacenters do |t|
      t.string :name
      t.integer :hosts
      t.integer :id_template_server
      t.integer :id_template_rs
      t.integer :id_template_node
      t.integer :id_zone
      t.references :infrastructure

      t.timestamps
    end
  end
end
