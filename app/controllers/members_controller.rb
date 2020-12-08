class MembersController < ApplicationController
  # ユーザー一覧
  def index
    @members = Member.order('number')
  end

  # 検索
  def search
    @members = Member.search(params[:q])
    render 'index'
  end

  # 会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
  end

  # 更新フォーム
  def edit
    @member = Member.find(params[:id])
  end

  # 会員の新規登録
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: '会員を登録しました。'
    else
      render 'new'
    end
  end

  def update; end

  def destroy; end

  private

  def member_params
    attrs = %i[
      number
      name
      full_name
      sex
      birthday
      email
      administrator
    ]

    params.require(:member).permit(attrs)
  end
end
