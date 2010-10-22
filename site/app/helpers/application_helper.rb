module ApplicationHelper
  def format_authors(authors)
    authors.blank? ? 'No authors specified' : authors.to_sentence
  end

  def markdown(text)
    RDiscount.new(text, :smart, :filter_html).to_html
  end
end
