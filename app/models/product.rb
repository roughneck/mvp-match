class Product < ApplicationRecord
  belongs_to :user

  validates :amount_available, :name, :user, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }

  validate :cost_is_multiple_of_5

  def cost_is_multiple_of_5
    unless (self.cost % 5) == 0
      errors.add(:cost, 'not multiple of 5')
    end
  end
end
