class TracksController < ApplicationController
  before_action :find_activity
  before_action :find_track, only: %i[index show update destroy]

  def index
    render json: track.new(@activity.tracks)
  end

  def show
    render json: track.new(@track)
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      render json: @track, status: 201
    else

      render json: { error: 'Unable to create Date' }, status: 422
    end
  end

  def update
    if @track
      @track.update(track_params)
      render json: { message: 'Date succesfully updated' }, status: 200
    else
      render json: { error: 'Unable to update Date' }, status: 422
    end
  end

  def destroy
    if @track
      @track.destroy
      render json: { message: 'Date succesfully deleted' }, status: 200
    else

      render json: { error: 'Unable to delete Date' }, status: 422
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :distance, :duration, :repeat)
  end

  def find_track
    @track = Tracking.find(params[:id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end
end
