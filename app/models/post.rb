class Post < ActiveRecord::Base
    validates :title, presence: true
    validates_length_of :summary, maximum: 250
    validates_length_of :content, minimum: 250
    validates :category, inclusion: { in: %w(Non-Fiction, Fiction)}
    validate :click_bait, on: :create

 CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def click_bait
    if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match(self.title)}
      self.errors.add(:title, "is not clickbait enough")
    end
  end
end