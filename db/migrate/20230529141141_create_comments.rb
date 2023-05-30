class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :cook, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
