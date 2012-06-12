class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end #show

  def new
    if signed_in? 
      redirect_to root_path
    else
      @user = User.new
    end #if
  end #new

  def create
    if signed_in? 
      redirect_to root_path
    else #not signed in
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to RoR App 1!"
        redirect_to @user
      else
        render 'new'
      end #if else
    end # not signed in
  end #create

  def edit
  end #edit

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end #destroy

  def index 
    @users = User.paginate(page: params[:page])
  end #index

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end #if else
  end #update

  private 

#  def signed_in_user
#    unless signed_in?
#      store_location
#      redirect_to signin_path, notice: "Please sign in."
#    end #unless signed_in
#  end #signed_in_user

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end #correct_user

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end #admin_user

end # class UsersController