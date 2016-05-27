class Currency < ActiveRecord::Base
	has_many :sales
	validates :burma, presence: true, numericality: {only_integer: true}
	validates :us, presence: true, numericality: {only_integer: true}
end
