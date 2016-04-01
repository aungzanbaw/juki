class Part < ActiveRecord::Base
  
  belongs_to :machine

  validates_associated :machine
  validates :model, presence: true, uniqueness: true
	validates :stock, presence: true, numericality: {only_integer: true} 
	validates :qty, presence: true, numericality: {only_integer: true}
	validates :price, presence: true, numericality: {only_integer: true}

	#validates :price, presence: true, numericality: {only_integer: true}, on: :create
end
