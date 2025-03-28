class MudSerializer < ActiveModel::Serializer
  attributes :id

  has_many :layers
  has_one :export
  has_one :water
  has_one :weathering
  has_one :albedo

  def layers
    object.layers.order(position: :asc).map do |layer|
      LayerSerializer.new(layer).as_json
    end
  end
end
