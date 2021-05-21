class TrackingsController < ApplicationController
  before_action :find_activity
  before_action :find_tracking, only: %i[index show update destroy]

  def index
    render json: TrackingSerializer.new(@activity.trackings)
  end

  def show
    render json: TrackingSerializer.new(@tracking)
  end

  def create
    @tracking = Tracking.new(tracking_params)

    if @tracking.save
      render json: @tracking, status: 201
    else

      render json: { error: 'Unable to create Date' }, status: 422
    end
  end

  def update
    if @tracking
      @tracking.update(tracking_params)
      render json: { message: 'Date succesfully updated' }, status: 200
    else
      render json: { error: 'Unable to update Date' }, status: 422
    end
  end

  def destroy
    if @tracking
      @tracking.destroy
      render json: { message: 'Date succesfully deleted' }, status: 200
    else

      render json: { error: 'Unable to delete Date' }, status: 422
    end
  end

  private

  def tracking_params
    params.require(:tracking).permit(:date, :pulse, :duration, :distance, :calories, :rate, :activity_id, :id)
  end

  def find_tracking
    @tracking = Tracking.find(params[:id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end
end
