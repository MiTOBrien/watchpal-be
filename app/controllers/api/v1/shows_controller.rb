class Api::V1::ShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_show, only: [:show, :update, :destroy]

  # GET /api/v1/shows
  def index
    @shows = current_user.shows.order(:air_day, :air_time)
    render json: @shows
  end

  # GET /api/v1/shows/:id
  def show
    render json: @show
  end

  # POST /api/v1/shows
  def create
    @show = current_user.shows.build(show_params)
    if @show.save
      render json: @show, status: :created
    else
      render json: { errors: @show.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/shows/:id
  def update
    if @show.update(show_params)
      render json: @show
    else
      render json: { errors: @show.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shows/:id
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
