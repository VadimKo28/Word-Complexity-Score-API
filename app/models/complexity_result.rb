class ComplexityResult < ApplicationRecord 
  validates :job_id, presence: true
  validates :status, presence: true

  enum :status, { pending: 0, in_progress: 1, completed: 2 }
end
