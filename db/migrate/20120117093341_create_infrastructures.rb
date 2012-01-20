class CreateInfrastructures < ActiveRecord::Migration
  def change
    create_table :infrastructures do |t|
      t.string :name
      t.string :infrastructure_type

      t.timestamps
    end
  end
end
