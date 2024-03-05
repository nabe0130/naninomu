# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# アプリケーション全体の設定とカスタマイズを行うモジュールです。
# ここでの設定は全ての環境に適用され、環境ごとの設定ファイルで上書きすることができます。
module Naninomu
  # アプリケーションの基本設定を行うクラスです。
  # Railsアプリケーションの初期化プロセスや設定のデフォルト値を定義しています。
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.i18n.default_locale = :ja

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
