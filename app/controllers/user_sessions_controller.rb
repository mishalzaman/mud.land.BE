class UserSessionsController < ApplicationController

  # POST /user_sessions
  def create
    session_record = UserSession.create!
    render json: { id: session_record.id }, status: :ok
  end

  # DELETE /user_sessions/:id
  def destroy
    session = UserSession.find_by(id: params[:id])
    
    if session
      session.destroy
      render json: { message: "User Session destroyed" }, status: :ok
    else
      render json: { error: "User Session not found" }, status: :not_found
    end
  end
  
end
