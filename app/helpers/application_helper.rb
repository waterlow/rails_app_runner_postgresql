# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'

    page_title.empty? ? base_title : "#{page_title} | Ruby on Rails Tutorial Sample App"
  end
end
