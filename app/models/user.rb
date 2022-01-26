class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[buyer seller] }

  # NOTE: Would have used Pundit if this was a real project but due to time limitations, I'm using this simple approach
  def role?(role)
    self.role == role
  end
end
