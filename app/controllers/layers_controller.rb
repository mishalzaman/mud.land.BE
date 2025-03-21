class LayersController < ApplicationController
  before_action :get_user_session

  # GET /user_sessions/:user_session_id/layers
  def index
    render json: { layers: @user_session.procedural_layers }, status: :ok
  end

  # POST /user_sessions/:user_session_id/layers
  def create
    type = layer_params[:type]
    variant = layer_params[:variant]
    
    layer_class = type.to_s.safe_constantize

    # return error if the type is not found
    return render json:
      { error: "Invalid type" },
      status: :unprocessable_entity unless layer_class&.respond_to?(:defaults_for)

    defaults = layer_class.defaults_for(variant)

    return render json: { error: "Invalid variant" }, status: :unprocessable_entity unless defaults

    layerable = layer_class.create(defaults)
    layer = @user_session.layers.build(layerable: layerable, position: @user_session.layers.count)
  
    if layer.save
      render json: layer, status: :created
    else
      render json: { errors: layer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /user_sessions/:user_session_id/layers/:id
  def destroy
    # TODO
  end

  private

  def layer_params
    params.require(:procedural_layer).permit(:type, :variant)
  end

  def get_user_session
    @user_session = UserSession.find_by(id: params[:user_session_id])
    render json: { error: "User session not found" }, status: :not_found unless @user_session
  end
end
