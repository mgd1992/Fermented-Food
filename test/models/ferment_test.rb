# == Schema Information
#
# Table name: ferments
#
#  id                   :bigint           not null, primary key
#  description          :text
#  fermentation_time    :string
#  ingredients          :text
#  instructions         :text
#  name                 :string
#  review_date          :date
#  review_reminder_sent :boolean          default(FALSE), not null
#  revisar_fermentos    :integer
#  share_token          :string
#  start_date           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_ferments_on_share_token  (share_token) UNIQUE
#  index_ferments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class FermentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
