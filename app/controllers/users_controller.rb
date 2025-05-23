class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # GET users/new
  def new
    @user = User.new
  end

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
  # render create

  private

  def user_params # 引数部分をメソッドとして定義
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
