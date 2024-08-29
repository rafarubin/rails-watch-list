class Movie < ApplicationRecord
  before_destroy :check_for_bookmarks
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, :overview, presence: true
  validates :title, uniqueness: true

  def check_for_bookmarks
    return unless bookmarks.empty?
    errors.add(:base, "Cannot delete movie")
    throw(:abort)
  end
end
