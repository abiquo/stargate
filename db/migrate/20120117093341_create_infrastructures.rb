class CreateInfrastructures < ActiveRecord::Migration
  def change
    create_table :infrastructures do |t|
      t.string :name
      t.string :infrastructure_type
      t.boolean :deployed
      t.integer :id_zone

      t.timestamps
    end
  end
end
