// Bootstrap
import 'bootstrap';

// Custom stylesheets
import '../stylesheets/application';

// 指定されたファイル './alcohol_range' が存在するか確認してください。
// 存在しない場合は、以下の行を削除してください。
import './alcohol_range';

import './bookmarks'

import 'jquery'

// RailsのJavaScript機能をインポート
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
// RailsのJavaScript機能を起動
Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ここにカスタムJavaScriptコードを追加することができます。
