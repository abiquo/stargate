class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :option
      t.string :value

      t.timestamps
    end
  end
end
