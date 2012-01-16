class Configuration < ActiveRecord::Base
  validates   :option, :presence => true
end
