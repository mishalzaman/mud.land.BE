class LayersController < ApplicationController
  before_action :get_user_session

  # GET /user_sessions/:user_session_id/layers
  def index
    layers = @user_session.layers.includes(:layerable)
    render json: layers, each_serializer: LayerSerializer, status: :ok
  end  

  # POST /user_sessions/:user_session_id/layers
  def create
    result = LayerCreator.create_for(
      layer_params[:type],
      layer_params[:variant],
      @user_session
    )
    
    if result.is_a?(Hash) && result[:error].present?
      # A hash with error info was returned
      status_code = case result[:code]
                    when :missing_type, :missing_variant, :invalid_type, :invalid_variant
                      :bad_request
                    when :validation_error, :layer_creation_error
                      :unprocessable_entity
                    else
                      :internal_server_error
                    end
      
      render json: { error: result[:error], details: result[:details] }, status: status_code
    else
      render json: result, status: :created
    end
  end
  
  # DELETE /user_sessions/:user_session_id/layers/:id
  def destroy
    layer = @user_session.layers.find_by(id: params[:id])

    if layer.nil?
      render json: { error: "Layer not found" }, status: :not_found
      return
    end

    Layer.transaction do
      deleted_position = layer.position
      if layer.destroy
        # Shift down positions of layers after the deleted one
        @user_session.layers.where("position > ?", deleted_position).order(:position).each do |l|
          l.update!(position: l.position - 1)
        end
        head :no_content
      else
        render json: { error: "Failed to delete layer", details: layer.errors.full_messages },
              status: :unprocessable_entity
      end
    end
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
