class CreateLabelTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_table :label_task_lists, id: :uuid do |t|
      t.references :label, foreign_key: { on_delete: :cascade }, type: :uuid, null: false
      t.references :task_list, foreign_key: { on_delete: :cascade }, type: :uuid, null: false
    end
    add_index :label_task_lists, [:label_id, :task_list_id], unique: true
  end
end
