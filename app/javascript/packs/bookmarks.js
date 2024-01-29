$(document).on('ajax:success', '.favorite-icon-link', function(event) {
    var data = event.detail[0]; // Ajaxレスポンスのデータ
    var icon = $(this).find('i'); // ボタン内のアイコン要素を取得

    if (data.bookmarked) {
        icon.removeClass('bi-heart').addClass('bi-heart-fill'); // お気に入り追加時のアイコンに変更
    } else {
        icon.removeClass('bi-heart-fill').addClass('bi-heart'); // お気に入り解除時のアイコンに変更
    }
});
