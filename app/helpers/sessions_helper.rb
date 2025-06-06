module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    session[:session_token] = user.session_token
  end

  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember(user)
    # newトークンを生成
    user.remember
    # usersidを暗号化
    cookies.permanent.encrypted[:user_id] = user.id
    # tempのremember_token領域にトークンをset
    cookies.permanent[:remember_token] = user.remember_token
  end

  # DBへの問い合わせの数を減らしたい
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    # 同値チェックでなく存在チェック
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
      # cookieに情報あるか？
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  # アクセスしようとしたURLをsessionに保存する
  def store_location
    session[:forwarding_url] = request.original_url if request.get? # web経由でリクエストが投げられたときにだけ発動
  end

  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end
end
