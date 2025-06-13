class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy following followers]
  before_action :correct_user,   only: %i[edit update]
  before_action :admin_user,     only: :destroy

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET users/new
  def new
    @user = User.new
  end

  # render create
  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      # =>Success alert-success
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity # ユーザにエラー原因表示するためのオプション（ブラウザ側）
      # render new により失敗時Userのデータを入れ込んだnewテンプレートを表示(Failure)
    end
  end

  # GEt /users/ :id /edit
  def edit
    @user = User.find(params[:id])
    # app/views/users/:id/edit.html
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      # @users.errors <= ここにデータ入ってる
      render 'edit', status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url, status: :see_other
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params # 引数部分をメソッドとして定義
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
