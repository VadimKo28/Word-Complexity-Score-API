class ComplexityResult < ApplicationRecord 
  validates :job_id, presence: true
  validates :status, presence: true
  validates :result, presence: true

  enum :status, { pending: 0, in_progress: 1, completed: 2 }, default: :pending
end
