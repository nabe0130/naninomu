# frozen_string_literal: true

module Users
  # Users::OmniauthCallbacksControllerは、外部サービスを利用したユーザー認証を管理するコントローラです。
  # DeviseとOmniAuthを組み合わせて、GoogleやFacebookなどのサービスからの認証情報に基づくログイン処理を実装します。
  # このクラスでは、各サービスごとの認証コールバックを処理するためのアクションを定義します。
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # callback for google
    def line
      # stateパラメータの検証
      if session.delete(:omniauth_state) != request.env['omniauth.params']['state']
        redirect_to new_user_session_path, alert: 'CSRF検出されました。'
        return
      end

      # stateが一致した場合の処理を続ける
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'LINE') if is_navigational_format?
      else
        session['devise.omniauth_data'] = request.env['omniauth.auth'].except('extra')
        redirect_to new_user_registration_url
      end
    end

    # Google認証のコールバックを処理
    def google_oauth2
      basic_action(:google)
    end

    private

    def basic_action(provider)
      @omniauth = request.env['omniauth.auth']
      if @omniauth.present?
        @user = User.from_omniauth(@omniauth)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
        else
          session['devise.omniauth_data'] = @omniauth.except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
      else
        redirect_to root_path, alert: '認証情報を取得できませんでした。'
      end
    end

    def failure
      redirect_to new_user_session_path, alert: '外部サービスを通じた認証に失敗しました。'
    end
  end
end
