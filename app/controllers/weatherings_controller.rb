class WeatheringsController < ApplicationController
  before_action :get_user_session

  def show
    weathering = @user_session.weathering

    if weathering
      render json: weathering, serializer: WeatheringSerializer, status: :ok
    else
      render status: :not_found
    end
  end

  def update
    # TODO
  end

  private 

  def get_user_session
    @user_session = UserSession.find_by(id: params[:user_session_id])
    render json: { error: "User session not found" }, status: :not_found unless @user_session
  end
end
