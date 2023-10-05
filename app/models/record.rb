class Record < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :images

  validates :weight, presence: true
end
