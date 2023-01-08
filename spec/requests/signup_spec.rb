# frozen_string_literal: true

require 'rails_helper'

describe 'signup', type: :request do
  describe 'GET /' do
    it 'should get home' do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end
end
