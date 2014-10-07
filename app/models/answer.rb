class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments
  validates :body, presence: true
end
