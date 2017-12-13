class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎回来: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
    redirect_to root_url, :flash => flash
  end

  def create_sign
    newuser = User.new
    newuser.name = params[:session][:name]
    newuser.email = params[:session][:email].downcase
    # newuser.role = params[:session][:role]
    newuser.password_digest = User.digest(params[:session][:password])
    # newuser.sex = params[:session][:sex]
    # newuser.phonenumber = params[:session][:phonenumber]
    # newuser.status = params[:session][:status]
    if newuser.save!    #加上!会知道哪里不能保存通过 
      flash= {:info => "注册成功 : #{newuser.name} "}
    else
      flash = {:danger => params[:session][:name]+" "+params[:session][:email].downcase+"  "+params[:session][:password] }
    end
    redirect_to root_url, :flash => flash
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :sex, :department_id, :password,
                                 :phonenumber, :status)
  end
  
  def new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
