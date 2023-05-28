class CreateCooks < ActiveRecord::Migration[6.1]
  def change
    create_table :cooks do |t|
      t.string :title, null: false
      t.text :describe
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
