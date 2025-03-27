class CreateWaters < ActiveRecord::Migration[8.0]
  def change
    create_table :waters, id: :uuid do |t|
      t.references :user_session, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
    end
  end
end
