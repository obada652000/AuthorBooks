require 'csv'

class Book < ApplicationRecord
  belongs_to :author
  validates :name, :release_date, presence: true
  validates :name, uniqueness: { message: ' already exist !' }
  validate :release_date_not_in_future

  filterrific(
    available_filters: [
      :by_book_author_name,
      :by_release_date
    ]
  )

  scope :by_book_author_name, ->(name) {
    lower_name = "%#{name.downcase}%"
    joins(:author).where('LOWER(books.name) LIKE ? OR LOWER(authors.name) LIKE ?', lower_name, lower_name)
  }
  
  
  scope :by_release_date, ->(date) {
    where('books.release_date >= ?', date.to_date)
  }

  def release_date_not_in_future
    errors.add(:release_date, "can't be in the future") if release_date.present? && release_date.future?
  end

  def self.to_csv
    attributes = ['Name', 'Author Name', 'Release Date']

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |book|
        csv << [
          book.name,
          book.author.name,
          book.release_date
        ]
      end
    end
  end
end
