class EntriesController < ApplicationController
  before_action :login_required, except: %i[index show]

  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member)
                       .order(posted_at: :desc).page(params[:page]).per(3)
  end

  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def edit
    @entry = current_member.entries.find(params[:id])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.member = current_member
    if @entry.save
      redirect_to @entry, notice: '記事を作成しました。'
    else
      render 'new'
    end
  end

  private

  def entry_params
    attrs = %i[
      member_id
      title
      body
      posted_at
      status
    ]

    params.require(:entry).permit(attrs)
  end
end
