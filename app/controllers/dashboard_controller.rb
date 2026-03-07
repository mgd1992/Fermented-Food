class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @ferments_active    = current_user.ferments.where(review_reminder_sent: false).count
    @ferments_completed = current_user.ferments.where(review_reminder_sent: true).count
    @likes_received     = Like.joins(:ferment).where(ferments: { user_id: current_user.id }).count
    @comments_received  = Comment.joins(:ferment).where(ferments: { user_id: current_user.id }).count
    @photos_count       = current_user.ferments.joins(:photos_attachments).count
    @ferments_expiring  = expiring_ferments
    @recent_comments    = recent_comments
    @recent_likes       = recent_likes
    @ferments_by_month  = current_user.ferments.group_by_month(:created_at, last: 6).count
  end

  private

  def expiring_ferments
    current_user.ferments
                .where(review_date: Time.zone.today..7.days.from_now)
                .where(review_reminder_sent: false)
                .order(:review_date)
  end

  def recent_comments
    Comment.joins(:ferment)
           .where(ferments: { user_id: current_user.id })
           .where.not(user_id: current_user.id)
           .includes(:user, :ferment)
           .order(created_at: :desc)
           .limit(5)
  end

  def recent_likes
    Like.joins(:ferment)
        .where(ferments: { user_id: current_user.id })
        .includes(:user, :ferment)
        .order(created_at: :desc)
        .limit(5)
  end
end
