# frozen_string_literal: true

require 'rails_helper'

describe 'login', type: :request do
  describe 'GET /login' do
    it 'should get home' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
end
