class User < ApplicationRecord

  before_destroy :the_last_admin_deleting
  before_update :the_last_admin_updating

  class Error < StandardError
  end

  has_many :appointments
  has_many :doctors, through: :appointments
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :name, length: { minimum: 3 }
  validates :email,
            format: { with: /\A(.+)@(.+)\z/, message: "wrong format"  },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }
  # validates_associated :appointments
  has_secure_password


  private

  def the_last_admin_deleting
    admins = User.where(['role = ?', 'admin'])
    if admins.count === 1
      if role === 'admin'
        raise Error.new "Can't delete the last admin"
      end
    end
  end

  def the_last_admin_updating
    admins = User.where(['role = ?', 'admin'])
    if admins.count === 1
      if role === 'user'
        raise Error.new "Can't set user from the last admin"
      end
    end
  end

end
