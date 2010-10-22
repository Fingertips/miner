module ApplicationHelper
  def format_authors(authors)
    authors.blank? ? 'No authors specified' : authors.to_sentence
  end
end
