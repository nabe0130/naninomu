// RailsのWebpacker設定をインポートします。
const { environment } = require('@rails/webpacker')

// Webpackモジュールをインポートします。
const webpack = require('webpack')

// Webpackのプラグイン機能を使用して、グローバル変数を提供する設定を追加します。
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  // 以下の設定では、jQuery関連の変数（$とjQuery）とPopper.jsの変数（Popper）を
  // グローバルスコープに自動的に割り当てます。これにより、これらのライブラリを
  // importやrequireすることなく、どのファイルからでも直接使用できるようになります。
  $: 'jquery',        // '$'をグローバル変数としてjQueryに割り当てます。
  jQuery: 'jquery',   // 'jQuery'もグローバル変数としてjQueryに割り当てます。
  Popper: ['popper.js', 'default'] // 'Popper'をグローバル変数としてPopper.jsのデフォルトエクスポートに割り当てます。
}))

// 最終的なWebpacker環境設定をエクスポートします。
module.exports = environment
