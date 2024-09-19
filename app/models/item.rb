class Item < ApplicationRecord
  belongs_to :subcategory
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subcategory_id, presence: true
end
