class GradientNoiseLayerSerializer < ActiveModel::Serializer
  attributes :name, 
             :blend_mode, 
             :opacity, 
             :octaves, 
             :seed, 
             :offset_x, 
             :offset_y, 
             :scale_height, 
             :scale_width
end
