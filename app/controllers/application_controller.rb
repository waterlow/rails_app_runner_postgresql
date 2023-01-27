# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  rescue_from Exception do |exception|
    render plain: [exception.message, exception.backtrace].flatten.join("\n")
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
