class LayerSerializer < ActiveModel::Serializer
  attributes :id, :position, :type, :settings

  def type
    object.layerable_type
  end

  def settings
    return {} unless object.layerable
  
    serializer_class = "#{object.layerable_type}Serializer".safe_constantize
    return object.layerable.attributes if serializer_class.nil?
  
    serializer_class.new(object.layerable).as_json
  end  
end
