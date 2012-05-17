class AddTagSetToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :tagSet, :string

  end
end
