class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :user, foreign_key: { on_delete: :cascade }, type: :uuid, null: false

      t.timestamps
    end
  end
end
