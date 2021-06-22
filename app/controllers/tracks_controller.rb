class TracksController < ApplicationController
 before_action :set_track, only: %i[index show update destroy]

  def index
    @tracks = activity.tracks

    render json: serializer.new(@tracks)
  end

  def show
    render json: serializer.new(@track)
  end

  def create
    @track = activity.tracks.build(track_params)

    if @track.save
      render json: serializer.new(@track), status: :created
    else

      render json: @track.errors, status: :unprocessable_entity
    end
  end

  def update
    if @track.update(track_params)
      render json: serializer.new(@track)
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @track.destroy
  end

  private

  def set_track
    @track = activity.tracks.find(params[:id])
  end

  def track_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:name, :distance, :duration, :repeat) || ApplicationController::Parameters.new
  end

  def serializer
    TrackSerializer
  end

  def activity
    Activity.all.find(params[:activity_id])
  end
end
