class LayerCreator
  def self.create_for(type, variant, user_session)
    return { error: "Type parameter is missing", code: :missing_type } if type.blank?
    return { error: "Variant parameter is missing", code: :missing_variant } if variant.blank?
    
    klass = type.to_s.safe_constantize
    return { error: "Invalid layer type: #{type}", code: :invalid_type } unless klass&.respond_to?(:defaults_for)
    
    defaults = klass.defaults_for(variant)
    return { error: "Invalid variant: #{variant} for layer type: #{type}", code: :invalid_variant } unless defaults
    
    layerable = klass.new(defaults)
    unless layerable.save
      return { error: "Failed to create layer: #{layerable.errors.full_messages.join(', ')}", 
               code: :validation_error, 
               details: layerable.errors.full_messages }
    end
    
    layer = user_session.layers.create(layerable: layerable, position: user_session.layers.count)
    if layer.persisted?
      layer
    else
      { error: "Failed to add layer to session: #{layer.errors.full_messages.join(', ')}", 
        code: :layer_creation_error,
        details: layer.errors.full_messages }
    end
  end
end