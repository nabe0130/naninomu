# frozen_string_literal: true

# BookmarksControllerはApplicationControllerを継承しており、
# アプリケーションのコントローラーが共通で持つべき機能を利用できます。
class BookmarksController < ApplicationController
  # createアクションは、新しいブックマークを作成するためのものです。
  def create
    @drink = Drink.find_by(id: params[:drink_id])
    if @drink
      # 既存のブックマークを検索します。
      existing_bookmark = current_user.bookmarks.find_by(drink: @drink)

      respond_to do |format|
        if existing_bookmark
          # 既に存在する場合は、そのブックマークを削除します。
          existing_bookmark.destroy
          format.html { redirect_back fallback_location: root_path, notice: 'お気に入りを解除しました。' }
          format.json { render json: { bookmarked: false } }
          format.js { render :toggle } # toggle.js.erb をレンダリング
        else
          # 存在しない場合は、新たにブックマークを作成します。
          @bookmark = current_user.bookmarks.create(drink: @drink)
          if @bookmark.persisted?
            format.html { redirect_back fallback_location: root_path, notice: 'お気に入りに登録しました。' }
            format.json { render json: { bookmarked: true } }
            format.js { render :toggle } # toggle.js.erb をレンダリング
          else
            format.json { render json: { bookmarked: false, error: 'お気に入りの登録に失敗しました。' }, status: :unprocessable_entity }
          end
        end
      end
    else
      render json: { error: 'カクテルが見つかりませんでした。' }, status: :not_found
    end
  end

  # destroyアクションは、ブックマークを削除するためのものです。
  def destroy
    # 現在ログインしているユーザーのブックマークから、指定されたdrink_idに該当するものを検索します。
    @bookmark = current_user.bookmarks.find_by(drink_id: params[:drink_id])

    # @bookmarkが存在し、かつ削除が成功した場合、以下のブロックが実行されます。
    if @bookmark&.destroy
      # レスポンスのフォーマットをクライアントの要求に応じて変更します。
      respond_to do |format|
        # HTML形式のリクエストに対しては、前のページにリダイレクトします。
        format.html { redirect_back fallback_location: root_path, notice: 'お気に入りを解除しました。' }
        # JSON形式のリクエストに対しては、JSONオブジェクトを返します。
        format.json { render json: { bookmarked: false } }
        # JavaScript形式のリクエストに対しては、対応するJSビューをレンダリングします。
        format.js
      end
    else
      # ブックマークの削除に失敗した場合、エラーメッセージを返します。
      render json: { error: 'お気に入りを解除できませんでした。' }, status: :unprocessable_entity
    end
  end
end
