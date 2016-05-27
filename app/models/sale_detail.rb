class SaleDetail < ActiveRecord::Base
  belongs_to :sale 
  belongs_to :itemable, polymorphic: true 
  
  validates_associated :sale 
  validates :itemable_id, presence: true, numericality:{only_integer: true}
  validates :itemable_type, presence: true  
  validates :qty, presence: true, numericality:{only_integer: true}
  
end
