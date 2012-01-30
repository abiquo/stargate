class Infrastructure < ActiveRecord::Base 
  has_many    :datacenters
  accepts_nested_attributes_for :datacenters, :allow_destroy => true
    
  validates   :name, :presence => true
  validates   :infrastructure_type, :presence => true
  validates   :deployed, :inclusion => { :in => [true, false] }
end
