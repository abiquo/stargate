class AddIpToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :public_ip, :string

  end
end
