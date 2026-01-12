class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :ferments, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_nil: true, on: :update


  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
