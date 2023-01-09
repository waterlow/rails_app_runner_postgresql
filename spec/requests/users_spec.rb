# frozen_string_literal: true

require 'rails_helper'

describe 'users', type: :request do
  describe 'POST /users' do
    it 'valid signup information' do
      request_proc = lambda {
        post(
          users_path,
          params: { user: { name: 'Example User',
                            email: 'user@example.com',
                            password: 'password',
                            password_confirmation: 'password' } }
        )
      }
      expect(&request_proc).to change { User.count }.from(0).to(1)
      follow_redirect!
      expect(response.body).to include('Welcome to the Sample App!')
    end

    it 'invalid signup information' do
      request_proc = lambda {
        post(
          users_path,
          params: { user: { name: '',
                            email: 'user@example.com',
                            password: 'pass',
                            password_confirmation: 'word' } }
        )
      }
      expect(&request_proc).not_to change { User.count }.from(0)
      expect(response).to have_http_status(422)
      expect(css_select('#error_explanation')).to be_present
    end
  end
end
