class AddMissingFieldsToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :instanceState, :string

    add_column :instances, :privateDnsName, :string

    add_column :instances, :dnsName, :string

    add_column :instances, :reason, :string

    add_column :instances, :amiLaunchIndex, :string

    add_column :instances, :productCodes, :string

    add_column :instances, :launchTime, :date

    add_column :instances, :placement, :string

    add_column :instances, :kernelId, :string

    add_column :instances, :monitoring, :string

    add_column :instances, :stateReason, :string

    add_column :instances, :blockDeviceMapping, :string

    add_column :instances, :virtualizationType, :string

    add_column :instances, :clientToken, :string

  end
end
