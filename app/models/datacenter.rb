class Datacenter < ActiveRecord::Base
  belongs_to                  :infrastructure
  
  validates                   :name, :presence => true
  validates                   :hosts, :presence => true
  validates_numericality_of   :hosts, :only_integer => true, :greater_than => 0
end
