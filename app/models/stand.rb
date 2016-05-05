class Stand < ActiveRecord::Base
	has_many :purchse_details, as: :stockable
	has_many :msale_details, as: :msaleable
	
	validates :brand, presence: true    
	validates :qty, presence: true, numericality: {only_integer: true} 
end
