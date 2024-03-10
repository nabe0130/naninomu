# frozen_string_literal: true

module Users
  # SessionsController は、ユーザーのセッション管理を担当するコントローラです。
  # これには、ログインとログアウト処理が含まれます。
  class SessionsController < Devise::SessionsController
    def create
      state = SecureRandom.hex(15)
      session[:omniauth_state] = state
      redirect_to user_line_omniauth_authorize_path(state: state)
    end
  end
end
