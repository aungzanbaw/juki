class Machine < ActiveRecord::Base
	has_many :parts
	has_many :needles
	has_many :purchse_details, as: :stockable
	has_many :msale_details, as: :msaleable

	validates :model, presence: true, uniqueness: true
	validates :series, presence: true
	validates :stock, numericality: {only_integer: true} 
	validates :qty, presence: true, numericality: {only_integer: true} 
end
