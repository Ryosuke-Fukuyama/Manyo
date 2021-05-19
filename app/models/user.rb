class User < ApplicationRecord
  before_destroy :admin_limit
  has_many :tasks, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  before_validation { email.downcase! }

  def admin_limit
    admin = User.all.find_by(admin: true)
    if admin.count == 1
      redirect_to admin_users_path, notice:"ユーザーを削除できませんでした！！"
    end
  end
end
