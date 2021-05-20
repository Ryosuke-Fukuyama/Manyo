class User < ApplicationRecord
  before_destroy :admin_limit      # dependent: :destroy より先に記述
  has_many :tasks, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  before_validation { email.downcase! }

  private

  def admin_limit
    user = User.find(id)
    admin_users = User.where(admin: true)
    throw(:abort) unless ( admin_users.size > 1 || user[:id] != current_user[:id] ) && user[:admin] != true
  end
end