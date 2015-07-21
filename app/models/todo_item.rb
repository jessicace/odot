class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :content, presence: true, length: { minimum: 3 }

  scope :complete, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }

  def completed?
    !completed_at.blank?
  end

  def toggle_completion!
    if completed?
      update_attribute(:completed_at, nil)
    else
      update_attribute(:completed_at, Time.now)
    end
  end
end
