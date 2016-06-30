class Needle < ActiveRecord::Base
  
  # belongs_to :machine
  has_many :purchse_details, as: :stockable
  has_many :sale_details, as: :itemable
  
  # validates_associated :machine 
  validates :model, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w{R RG FG FFG} , message: "Value must be valid needle category('R RG FG FFG')"}
  validates :size, presence: true 
	validates :stock, numericality: {only_integer: true}
	validates :qty, numericality: {only_integer: true}
	validates :price, numericality: {only_integer: true}
  
	#validates :price, presence: true, numericality: {only_integer: true}, on: :create
end
