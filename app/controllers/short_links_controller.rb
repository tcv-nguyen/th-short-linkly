class ShortLinksController < ApplicationController
  include ActionController::MimeResponds

  before_action :set_short_link, only: [:show, :analytic]

  def show
    @short_link&.update_columns(counter: @short_link.counter + 1)
    redirect_to @short_link.long_link, status: :moved_permanently
  end

  def create
    respond_to do |format|
      format.html do
        short_link = ShortLink.where(long_link: params[:long_link]).first_or_create(user_id: params[:user_id])
        if short_link.persisted?
          payload = {
            long_link: short_link.long_link,
            short_link: short_link_url(short_link.encoded_id)
          }
          render json: payload, status: 201
        else
          render json: short_link.errors, status: 422
        end
      end
    end
  end

  def analytic
    respond_to do |format|
      format.html do
        if @short_link&.persisted?
          payload = {
            long_link: @short_link.long_link,
            short_link: short_link_url(@short_link.encoded_id),
            counter: @short_link.counter
          }
          render json: payload, status: 200
        else
          render json: {}, status: 404
        end
      end
    end
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by_encoded_id(params[:id])
    head :not_found unless @short_link
  end
end
