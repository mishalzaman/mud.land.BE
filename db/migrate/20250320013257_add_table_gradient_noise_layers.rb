class AddTableGradientNoiseLayers < ActiveRecord::Migration[8.0]
  def change
    create_table :gradient_noise_layers, id: :uuid do |t|
      t.string :name, null: false
      t.string :blend_mode, null: false
      t.decimal :opacity, precision: 3, scale: 2, null: false, default: 1.0
      t.integer :octaves, null: false, default: 16
      t.integer :seed, null: false, default: 1234
      t.integer :offset_x, null: false, default: 0
      t.integer :offset_y, null: false, default: 0
      t.decimal :scale_height, precision: 4, scale: 4, null: false, default: 0.3
      t.decimal :scale_width, precision: 4, scale: 4, null: false, default: 0.3

      t.timestamps
    end
  end
end
