class TaskList < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :label_task_lists, dependent: :destroy
  has_many :labels, through: :label_task_lists

  validates :name, :status, presence: true

  aasm column: 'status' do
    state :pending, initial: true
    state :in_process
    state :done

    event :process do
      transitions from: [:pending], to: :in_process
    end

    event :complete do
      transitions from: [:pending, :in_process], to: :done
    end
  end
end