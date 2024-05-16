class Author < ApplicationRecord
  has_many :books
  validates :name, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  filterrific(
    available_filters: [
      :by_name
    ]
  )

  scope :by_name, ->(name) {
    where('LOWER(name)  LIKE ? ', "%#{name.downcase}%")
  }
end
