class Staff < ActiveRecord::Base
	has_many :sales
	validates :name, presence: true
	validates :phone, presence: true, numericality: {only_integer: true}
	validates :address, presence: true
	validates :password_digest, presence: true
end
