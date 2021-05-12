class StaticPagesController < ApplicationController
  def home
    render json: 'This is where the server side of my React "APP FRONT" application resides'
  end
end
