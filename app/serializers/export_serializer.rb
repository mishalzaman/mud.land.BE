class ExportSerializer < ActiveModel::Serializer
  attributes :id, :type

  def type
    "Export"
  end
end
