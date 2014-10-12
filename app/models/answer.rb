class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :attachments, as: :attachable

  validates :body, presence: true
  validates :question_id, presence: true

  accepts_nested_attributes_for :attachments
end
