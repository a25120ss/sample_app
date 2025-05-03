Rails.application.routes.draw do
  # GET / static_pagesコントローラーのhomeアクションを呼び出す
  root 'static_pages#home'

  # GET /static_pages/home => static_pages#home
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
end
