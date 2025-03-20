class CreateLayers < ActiveRecord::Migration[8.0]
  def change
    create_table :layers, id: :uuid do |t|
      t.references :session, null: false, foreign_key: true, type: :uuid
      t.references :layerabe, polymorphic: true, null: false, type: :uuid
      t.integer :position, null: false
      t.timestamps

      t.index [:session_id, :position], unique: true
    end
  end
end
