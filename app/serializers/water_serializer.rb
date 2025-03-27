class WaterSerializer < ActiveModel::Serializer
  attributes :id, :type

  def type
    "Water"
  end
end
