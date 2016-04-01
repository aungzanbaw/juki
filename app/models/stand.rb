class Stand < ActiveRecord::Base
	validates :brand, presence: true    
	validates :qty, presence: true, numericality: {only_integer: true}
	validates :price, presence: true, numericality: {only_integer: true}
end
