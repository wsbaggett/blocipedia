class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  has_many :collaborators
  has_many :collaborating_wikis, through: :collaborators, source: :wiki

  before_create { self.role ||= :standard }

  def downgrade
   self.standard!
   self.wikis.update_all(private: false)
  end

  enum role: [:standard, :premium, :admin]
end
