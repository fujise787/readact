class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
end