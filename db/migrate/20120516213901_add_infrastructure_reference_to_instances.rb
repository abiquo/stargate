class AddInfrastructureReferenceToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :infrastructure_id, :integer

  end
end
