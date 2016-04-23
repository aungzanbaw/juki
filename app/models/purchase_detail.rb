class PurchaseDetail < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :stockable, polymorphic: true

  validates :purchase_id, presence: true
  validates :stockable_id, presence: true
  validates :stockable_type, presence: true  
  validates :qty, presence: true, numericality:{only_integer: true}
  validates :price, presence: true, numericality:{only_integer: true}
end
