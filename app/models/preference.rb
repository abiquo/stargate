class Preference < ActiveRecord::Base
  validates   :option, :presence => true
end
