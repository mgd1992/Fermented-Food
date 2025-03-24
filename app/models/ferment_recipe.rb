class FermentRecipe < ApplicationRecord

  belongs_to :ferment
  belongs_to :user
end
