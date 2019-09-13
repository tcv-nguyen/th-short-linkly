class ShortLinksController < ApplicationController
  before_action :set_short_link, only: :show

  def show
    redirect_to @short_link.long_link, status: :moved_permanently
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by_encoded_id(params[:id])
    head :not_found unless @short_link
  end
end
