class AlbedoSerializer < ActiveModel::Serializer
  attributes :id, :type

  def type
    "Albedo"
  end
end
