class Motor < ActiveRecord::Base
	
	validates :brand, presence: true
	validates :watt, presence: true
	validates :price, presence: true, numericality: {only_integer: true}
	validates :qty, presence: true, numericality: {only_integer: true}
end
