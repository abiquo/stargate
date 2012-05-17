class AddIpsToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :privateIpAddress, :string

    add_column :instances, :ipAddress, :string
  end
end
