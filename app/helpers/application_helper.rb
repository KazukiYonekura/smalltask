module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      Constants::TITLE
    else
      "#{page_title} - #{Constants::TITLE}"
    end
  end
end
