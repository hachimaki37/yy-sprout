class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string  :name,         null: false, default: ""
      t.integer :squad_number, null: false, default: 0
      t.date    :birthday,                  default: "1000-01-01"
      t.integer :position,     null: false, default: 0
      t.string  :image

      t.timestamps
    end
  end
end
