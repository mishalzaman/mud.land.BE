class CreateLayers < ActiveRecord::Migration[8.0]
  def change
    create_table :layers, id: :uuid do |t|
      t.references :user_session, null: false, foreign_key: true, type: :uuid
      t.references :layerable, polymorphic: true, null: false, type: :uuid
      t.integer :position, null: false
      t.timestamps

      t.index [:user_session_id, :position], unique: true
    end
  end
end
