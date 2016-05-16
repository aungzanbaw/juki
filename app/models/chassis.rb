class Chassis < ActiveRecord::Base
  belongs_to :msale
  belongs_to :msale_detail
  
end
