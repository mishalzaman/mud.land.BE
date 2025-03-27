class ExportsController < ApplicationController
  before_action :get_user_session

  def show
    export = @user_session.export

    if export
      render json: export, serializer: ExportSerializer, status: :ok
    else
      render json: { error: "Export not found" }, status: :not_found
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
