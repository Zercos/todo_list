class LabelTaskList < ApplicationRecord
  belongs_to :label
  belongs_to :task_list

  validates :task_list_id, uniqueness: { scope: :label_id }
end
