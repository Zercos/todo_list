class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :task_lists, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :tasks, through: :task_lists

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :auth_token, presence: true, uniqueness: true
end
