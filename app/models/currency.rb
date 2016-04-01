class Currency < ActiveRecord::Base
	validates :burma, presence: true, numericality: {only_integer: true}
	validates :us, presence: true, numericality: {only_integer: true}
end
