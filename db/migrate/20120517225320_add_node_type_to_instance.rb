class AddNodeTypeToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :node_type, :string

  end
end
