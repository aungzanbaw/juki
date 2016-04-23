class Stand < ActiveRecord::Base
	has_many :purchse_details, as: :stockable
	
	validates :brand, presence: true    
	validates :qty, presence: true, numericality: {only_integer: true}
	validates :price, presence: true, numericality: {only_integer: true}
end
