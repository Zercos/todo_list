class Task < ApplicationRecord
  include AASM

  belongs_to :task_list
  has_one :user, through: :task_list
  has_many :label_tasks, dependent: :destroy
  has_many :labels, through: :label_tasks

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
