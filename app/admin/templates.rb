ActiveAdmin.register Template do
  controller do
    def sync   
      @conf = Preference.find(:all)
    
      configuration = Hash.new()
      @conf.each do |p|
        configuration[p.option] = p.value
      end
      ec2 = AWS::EC2::Base.new(:access_key_id => configuration['ACCESS_KEY_ID'], :secret_access_key => configuration['SECRET_ACCESS_KEY'])
      @ec2_images = ec2.describe_images(:owner_id => configuration['AMAZON_OWNER_ID']).imagesSet.item
    
      @ec2_images.each do |image|
        t = Template.new()
        if image["name"]
          t.name = image["name"]
        else
          t.name = image.tagSet.item[0].value
        end
        t.idRemote = image["imageId"]
      
        if Template.where(:idRemote => t.idRemote).count == 0
          t.save
        end
      end
      
      respond_to do |format|
        format.html { redirect_to admin_templates_url }
        format.json { head :ok }
      end 
    end
  end


  action_item :only => :index do
    link_to 'Synchronize', :action => 'sync'
  end

  index do
    column :name
    column :idRemote

    default_actions
  end
  
  filter  :name
  filter  :idRemote
end
