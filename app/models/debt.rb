class Debt < ActiveRecord::Base
  belongs_to :msale

  validates_associated :msale
  validates :amount, presence: true
  validates :date, presence: true
end
