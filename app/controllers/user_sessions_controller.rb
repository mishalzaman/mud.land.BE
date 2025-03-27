class UserSessionsController < ApplicationController

  # POST /user_sessions
  def create
    user_session = UserSession.create!
    
    Export.create!(user_session: user_session)
    Water.create!(user_session: user_session)
    Weathering.create!(user_session: user_session)
    Albedo.create(user_session: user_session);

    render json: { id: user_session.id }, status: :ok
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
