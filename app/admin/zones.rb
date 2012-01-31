ActiveAdmin.register Zone do
  config.comments = false
  
  controller do
    def sync   
      @conf = Preference.find(:all)
    
      configuration = Hash.new()
      @conf.each do |p|
        configuration[p.option] = p.value
      end
      ec2 = AWS::EC2::Base.new(:access_key_id => configuration['ACCESS_KEY_ID'], :secret_access_key => configuration['SECRET_ACCESS_KEY'])
      
      @ec2_zones = ec2.describe_availability_zones().availabilityZoneInfo.item
    
      @ec2_zones.each do |zone|
        z = Zone.new()

        z.name = zone.zoneName
        z.zoneId = zone.zoneName
      
        if Zone.where(:zoneId => z.zoneId).count == 0
          z.save
        end
      end
      
      respond_to do |format|
        format.html { redirect_to admin_zones_url }
        format.json { head :ok }
      end 
    end
  end
  
  action_item :only => :index do
    link_to 'Synchronize', :action => 'sync'
  end

  
  index do
    column :name do |zone|
      link_to zone.name, admin_zone_path(zone)
    end
    column :zoneId, :label => "Zone ID"
    
    default_actions
  end
  
  
  filter  :name
  filter  :zoneId, :label => "Zone ID"
end
