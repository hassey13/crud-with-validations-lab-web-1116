class Song < ActiveRecord::Base

  validates :title, presence: true
  validates :release_year, presence: true, if: :released
  validate :not_future_date?, if: :released
  validate :already_released_this_year?

  def not_future_date?
    unless self.release_year.nil?
      errors.add(:release_year, "must not be a future date") unless Date.today.year >= self.release_year
    end
  end

  def already_released_this_year?
    song = Song.find_by(title: self.title)
    errors.add(:release_year, "cannot release the same song title in the same year") if song && self.release_year == song.release_year
  end

end
