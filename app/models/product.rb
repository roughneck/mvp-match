class Product < ApplicationRecord
  belongs_to :user

  validates :amount_available, :name, :user, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }

  validate :cost_is_multiple_of_five

  def cost_is_multiple_of_five
    errors.add(:cost, 'not multiple of 5') unless (cost % 5).zero?
  end
end
