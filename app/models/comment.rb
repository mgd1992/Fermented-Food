class Comment < ApplicationRecord
  belongs_to :ferment
  belongs_to :user
end
