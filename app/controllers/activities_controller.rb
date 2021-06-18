class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show update destroy]
  before_action :authorize!

  def index
    @activities = current_user.activities.all
    render json: serializer.new(@activities)
  end

  def show
    render json: serializer.new(@activity)
  end

  def create
    activities = current_user.activities
    @activity = activities.build(activity_params)
    if activities.exists?(item: activity_params[:item])
      render json: { item: ['has already been taken'] }, status: :unprocessable_entity
    elsif @activity.save
      render json: serializer.new(@activity), status: :created, location: @activity
    else

      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def update
    if @activity.update(activity_params)

      render json: serializer.new(@activity)
    else

      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
  end

  private

  def set_activity
    @activity = current_user.activities.find(params[:id])
  end

  def activity_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:item) || ApplicationController::Parameters.new
  end

  def serializer
    ActivitySerializer
  end
end
