class Wiki < ApplicationRecord
  belongs_to :user

  has_many :collaborators
  has_many :collaborating_users, through: :collaborators, source: :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  def public?
    !self.private
  end

end
