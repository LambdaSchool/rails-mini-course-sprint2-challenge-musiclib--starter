class Album < ApplicationRecord

  scope :Available, -> {  where( available: true ).sort_by(&:name) }
  # scope :active_salaried, -> { where(deactivated_at: nil, pay_status: "salary") }
  
  belongs_to :artist
  has_many :songs

  validates :name, presence: true

  def length_seconds
    songs.reduce(0) { |length, song| length + song.length_seconds }
  end
end
