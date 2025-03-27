class WeatheringSerializer < ActiveModel::Serializer
  attributes :id, :type

  def type
    "Weathering"
  end
end
