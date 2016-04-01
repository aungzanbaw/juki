class Machine < ActiveRecord::Base
	has_many :parts
	has_many :needles
	
	validates :model, presence: true, uniqueness: true
	validates :series, presence: true
	validates :stock, presence: true, numericality: {only_integer: true} 
	validates :qty, presence: true, numericality: {only_integer: true} 
end
