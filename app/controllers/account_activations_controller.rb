# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    if (user = fetch_activation_target_user)
      user.activate
      log_in user
      flash[:success] = 'Account activated!'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end

  private

  def fetch_activation_target_user
    user = User.find_by(email: params[:email])
    user if user && !user.activated? && user.authenticated?(:activation, params[:id])
  end
end
