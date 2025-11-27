class Api::V1::ShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_show, only: [:show, :update, :destroy]

  def index
    @shows = current_user.shows.order(:air_day, :air_time)
    render json: ShowSerializer.new(@shows).serializable_hash
  end

  def show
    render json: ShowSerializer.new(@show).serializable_hash
  end

  def create
    @show = current_user.shows.build(show_params)
    if @show.save
      render json: ShowSerializer.new(@show).serializable_hash, status: :created
    else
      render json: { errors: @show.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @show.update(show_params)
      render json: ShowSerializer.new(@show).serializable_hash
    else
      render json: { errors: @show.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @show.destroy
    head :no_content
  end

  private

  def set_show
    @show = current_user.shows.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Show not found' }, status: :not_found
  end

  def show_params
    params.require(:show).permit(:show_name, :air_day, :air_time, :channel_name, :channel_number, :available_on)
  end
end
