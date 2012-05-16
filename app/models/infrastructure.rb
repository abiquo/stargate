class Infrastructure < ActiveRecord::Base 
  has_many    :datacenters
  accepts_nested_attributes_for :datacenters, :allow_destroy => true
  
  has_many    :instances
  accepts_nested_attributes_for :instances, :allow_destroy => true
  
  validates   :name, :presence => true
  validates   :infrastructure_type, :presence => true, :inclusion => { :in => ['AWS']}
  validates   :id_zone, :presence => true
end