class ActivsController < ApplicationController
  before_action :set_activ, only: %i[show update destroy]
  before_action :authorize!

  def index
    @activs = current_user.activs.all

    render json: serializer.new(@activs)
  end

  def show
    render json: serializer.new(@activ)
  end

  def create
    activs = current_user.activs
    @activ = activs.build(activ_params)
    if activs.exists?(item: activ_params[:item])
      render json: { item: ['has already been taken'] }, status: :unprocessable_entity
    elsif @activ.save
      render json: serializer.new(@activ), status: :created, location: @activ
    else
      render json: @activ.errors, status: :unprocessable_entity
    end
  end

  def update
    if @activ.update(activ_params)
      render json: serializer.new(@activ)
    else
      render json: @activ.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @activ.destroy
  end

  private

  def set_activ
    @activ = current_user.activs.find(params[:id])
  end

  def activ_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:item) || ApplicationController::Parameters.new
  end

  def serializer
    ActivSerializer
  end
end
