class RemovePublicIpToInstance < ActiveRecord::Migration
  def up
    remove_column :instances, :public_ip
      end

  def down
    add_column :instances, :public_ip, :string
  end
end
