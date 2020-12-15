class AccountsController < ApplicationController
  before_action :login_required, except: %i[new create]

  def show
    @member = current_member
  end

  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
  end

  def edit
    @member = current_member
  end

  def create
    @member = Member.new(account_params)
    if @member.save
      session[:member_id] = @member.id
      redirect_to :account, notice: 'アカウント登録しました。'
    else
      render 'new'
    end
  end

  def update
    @member = current_member
    @member.assign_attributes(account_params)
    if @member.save
      redirect_to :account, notice: 'アカウント情報を更新しました。'
    else
      render 'edit'
    end
  end

  private

  def account_params
    attrs = %i[
      new_profile_picture
      remove_profile_picture
      number
      name
      full_name
      sex
      birthday
      email
      password
    ]

    params.require(:account).permit(attrs)
  end
end
