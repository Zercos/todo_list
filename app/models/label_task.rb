class LabelTask < ApplicationRecord
  belongs_to :label
  belongs_to :task

  validates :task_id, uniqueness: { scope: :label_id }
end
