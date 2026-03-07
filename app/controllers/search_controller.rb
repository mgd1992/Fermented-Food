class SearchController < ApplicationController
  before_action :authenticate_user!

  def show
    @query = params[:query]
    if @query.present?
      @ferments = Ferment.search_by_details(@query)
                         .includes(photos_attachments: :blob, user: { photo_attachment: :blob })
                         .limit(10)
      @users = User.search_by_name(@query)
                   .with_attached_photo
                   .where.not(id: current_user.id)
                   .limit(6)
    else
      @ferments = []
      @users = []
    end
  end
end
