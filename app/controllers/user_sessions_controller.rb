class UserSessionsController < ApplicationController
  def create
    session_record = UserSession.create!
    render json: { id: session_record.id }, status: :ok
  end

  def destroy
    UserSession.find(params[:id]).destroy
    render json: { message: "Session destroyed" }, status: :ok
  end
end
