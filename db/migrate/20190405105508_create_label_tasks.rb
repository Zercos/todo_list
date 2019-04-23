class CreateLabelTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :label_tasks, id: :uuid do |t|
      t.references :label, foreign_key: { on_delete: :cascade }, type: :uuid, null: false
      t.references :task, foreign_key: { on_delete: :cascade }, type: :uuid, null: false
    end
    add_index :label_tasks, [:label_id, :task_id], unique: true
  end
end
