class Part < ActiveRecord::Base
  
  belongs_to :machine
  has_many :purchse_details, as: :stockable
	has_many :sale_details, as: :itemable

  validates_associated :machine
  validates :model, presence: true, uniqueness: true
	validates :stock, numericality: {only_integer: true}
	validates :qty, presence: true, numericality: {only_integer: true}
	validates :price, presence: true, numericality: {only_integer: true}

	#validates :price, presence: true, numericality: {only_integer: true}, on: :create
end
