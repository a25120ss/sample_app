class ApplicationController < ActionController::Base
  include SessionsHelper
  def create; end

  def destroy; end

  private

  # ユーザーのログインを確認する
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
