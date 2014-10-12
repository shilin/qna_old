class Question < ActiveRecord::Base
  has_many :answers
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, :body, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :attachments
end

