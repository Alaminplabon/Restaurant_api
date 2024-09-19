class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :items, dependent: :destroy
  validates :name, presence: true
  validates :category_id, presence: true
end
