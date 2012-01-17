class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :option
      t.string :value

      t.timestamps
    end
  end
end
