class Label < ApplicationRecord
  belongs_to :user
  has_many :label_task_lists, dependent: :destroy
  has_many :label_tasks, dependent: :destroy
  has_many :task_lists, through: :label_task_lists
  has_many :tasks, through: :label_tasks

  validates :name, :description, presence: true
end
