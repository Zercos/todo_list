class CreateTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_table :task_lists, id: :uuid do |t|
      t.string :name, null: false
      t.string :status, null: false
      t.text :description
      t.references :user, foreign_key: { on_delete: :cascade }, type: :uuid, null: false

      t.timestamps
    end
  end
end