class Needle < ActiveRecord::Base
  
  belongs_to :machine

  validates_associated :machine 
  validates :model, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w{R RG FG FFG} , message: "Value must be valid needle category('R RG FG FFG')"}
  validates :size, presence: true 
	validates :stock, presence: true, numericality: {only_integer: true} 
	validates :qty, presence: true, numericality: {only_integer: true}
	validates :price, presence: true, numericality: {only_integer: true}

	#validates :price, presence: true, numericality: {only_integer: true}, on: :create
end
