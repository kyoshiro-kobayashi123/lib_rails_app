Rails.application.routes.draw do
  # ユーザー関連のルート（ユーザー新規作成）
  resources :users, only: [ :new, :create ]

  # ログインセッション関連
  resource :session, only: [ :new, :create, :destroy ]

  # 本のリソース
  resources :books
  # 貸し借り
  resources :loans
  # ユーザーごとに貸出機能（loan）を設定
  resources :users do
    resources :loans, only: [ :create ] do
      # 返却処理のためのルート
      patch :return_book, on: :member
    end
  end

  # 健康チェック
  get "up" => "rails/health#show", as: :rails_health_check

  # 動的PWAファイルの読み込み（必要に応じて）
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # ルートパスの設定（書籍一覧を表示）
  root "books#index"
end
