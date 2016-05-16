class Delivery < ActiveRecord::Base
  belongs_to :msale
  belongs_to :staff
end
