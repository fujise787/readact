class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  has_one :highlight, dependent: :destroy
  has_one :summary, dependent: :destroy
  has_many :actions, dependent: :destroy

  # attributesの設定
  accepts_nested_attributes_for :highlight
  accepts_nested_attributes_for :summary
  accepts_nested_attributes_for :actions, allow_destroy: true

  validates :title, presence: true
end
