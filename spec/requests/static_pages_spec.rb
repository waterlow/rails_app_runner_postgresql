# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  base_title = 'Ruby on Rails Tutorial Sample App'

  describe 'GET /' do
    it 'should get home' do
      get root_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq(base_title)
    end
  end

  describe 'GET /static_pages/help' do
    it 'should get help' do
      get static_pages_help_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("Help | #{base_title}")
    end
  end

  describe 'GET /static_pages/about' do
    it 'should get about' do
      get static_pages_about_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("About | #{base_title}")
    end
  end

  describe 'GET /static_pages/contact' do
    it 'should get contact' do
      get static_pages_contact_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("Contact | #{base_title}")
    end
  end
end
