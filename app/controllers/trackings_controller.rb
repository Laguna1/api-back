class TrackingsController < ApplicationController
  before_action :set_tracking, only: %i[show update destroy]
  before_action :authorize!

  def index
    @trackings = activity.trackings.all

    render json: serializer.new(@trackings)
  end

  def show
    render json: serializer.new(@tracking)
  end

  def create
    @tracking = activity.trackings.build(tracking_params)

    if @tracking.save
      render json: serializer.new(@tracking), status: :created
    else
      render json: @tracking.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tracking.update(tracking_params)
      render json: serializer.new(@tracking)
    else
      render json: @tracking.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tracking.destroy
  end

  def progress
    @trackings = Tracking.joins(
      "INNER JOIN activities
        ON activities.id = trackings.activity_id
        AND activities.user_id = #{current_user.id}
        AND trackings.name = '#{params[:name]}'"
    )

    render json: serializer.new(@trackings)
  end

  private

  def set_tracking
    @tracking = activity.trackings.find(params[:id])
  end

  def tracking_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:name, :distance, :duration, :repeats) || ApplicationController::Parameters.new
  end

  def serializer
    TrackingSerializer
  end

  def activity
    current_user.activities.find(params[:activity_id])
  end
end
