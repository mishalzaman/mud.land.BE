class AddTableSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sessions, id: :uuid do |t|
      t.timestamps
    end
  end
end
