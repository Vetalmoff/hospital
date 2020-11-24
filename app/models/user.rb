class User < ApplicationRecord

  # before_destroy :the_last_admin_deleting

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

  # def the_last_admin_deleting
  #   admins = User.where(['role = ?', 'admin'])
  #   if admins.count.zerro?
  #     raise Error.new "Can't delete last admin"
  #   end
  # end
end
