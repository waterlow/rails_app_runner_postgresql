# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  base_title = 'Ruby on Rails Tutorial Sample App'
  link_count = ->(path) { css_select("a[href=\"#{path}\"]").size }

  describe 'GET /' do
    it 'should get home' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Welcome to the Sample App')
      expect(css_select('title').text).to eq(base_title)
      expect(link_count.call(root_path)).to eq(2)
      expect(link_count.call(help_path)).to eq(1)
      expect(link_count.call(about_path)).to eq(1)
      expect(link_count.call(contact_path)).to eq(1)
    end
  end

  describe 'GET /static_pages/help' do
    it 'should get help' do
      get help_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("Help | #{base_title}")
    end
  end

  describe 'GET /static_pages/about' do
    it 'should get about' do
      get about_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("About | #{base_title}")
    end
  end

  describe 'GET /static_pages/contact' do
    it 'should get contact' do
      get contact_path
      expect(response).to have_http_status(200)
      expect(css_select('title').text).to eq("Contact | #{base_title}")
    end
  end
end
