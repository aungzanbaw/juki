class MsaleDetail < ActiveRecord::Base
  belongs_to :msale
  belongs_to :msaleable, polymorphic: true 

  validates_associated :msale 
  validates :msaleable_id, presence: true, numericality:{only_integer: true}
  validates :msaleable_type, presence: true  
  validates :qty, presence: true, numericality:{only_integer: true}
  validates :price, presence: true, numericality:{only_integer: true}
end
