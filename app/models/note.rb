class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :highlights, dependent: :destroy
  has_one :summary, dependent: :destroy
  has_many :actions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
