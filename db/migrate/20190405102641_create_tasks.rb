class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.string :status, null: false
      t.references :task_list, foreign_key: { on_delete: :cascade }, type: :uuid, null: false

      t.timestamps
    end
  end
end
