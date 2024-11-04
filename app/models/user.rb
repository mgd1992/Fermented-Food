class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :ferments, dependent: :destroy
  has_many :ferment_recipes
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true


  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
