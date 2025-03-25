class LayerUpdater
  def self.update_for(id, data)
    layer = Layer.find_by(id: id)
    return unless layer

    variant = layer.layerable
    variant.update(data.permit!)
  end
end
