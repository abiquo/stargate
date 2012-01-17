class Infrastructure < ActiveRecord::Base
    validates   :infrastructure_type, :presence => true
end
