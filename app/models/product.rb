class Product < ApplicationRecord
  belongs_to :user

  validates :amount_available, :cost, :name, :user, presence: true
end
