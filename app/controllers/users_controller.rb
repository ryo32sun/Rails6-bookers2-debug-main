class UsersController < ApplicationController
  
  before_action :ensure_correct_user, only: [:update]
  before_action :ensure_guest_user, only: [:edit]
  def show
    @user = User.find(params[:id])
    @books = @user.books.order("#{sort_column} #{sort_direction}").page(params[:page])
    @book = Book.new
    @followers = @user.followers.all
    @today_books = @user.books.created_days_ago(0)
    @yesterday_books = @user.books.created_days_ago(1)
    @thisweek_books = @user.books.where(created_at: [1.week.ago.midnight..Time.now])
    @lastweek_books = @user.books.where(created_at: [3.week.ago.midnight..1.week.ago.end_of_day])
  end
  
  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE?', "#{create_at}%"]).count
    end
  end

  def index
    @users = User.page(params[:page])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def  ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
