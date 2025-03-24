class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one_attached :avatar

  has_many :ferments, dependent: :destroy
  has_many :ferment_recipes
  has_many :comments, dependent: :destroy


  validates :first_name, presence: true


  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
