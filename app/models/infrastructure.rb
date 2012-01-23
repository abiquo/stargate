class Infrastructure < ActiveRecord::Base 
  has_many    :datacenters
  accepts_nested_attributes_for :datacenters
    
  validates   :name, :presence => true
  validates   :infrastructure_type, :presence => true
  validates   :deployed, :inclusion => { :in => [true, false] }
end
