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
      redirect_to @entry, notice: 'エントリを作成しました。'
    else
      render 'new'
    end
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice: 'エントリを更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: '記事を削除しました。'
  end

  # いいね
  def like
    @entry = Entry.published.find(params[:id])
    current_member.voted_entries << @entry
    redirect_to @entry, notice: '投票しました。'
  end

  # いいねした一覧
  def voted
    @entries = current_member.voted_entries
                             .published.order('votes.created_at DESC')
                             .page(params[:page]).per(15)
  end

  # いいね取り消し
  def unlike
    current_member.voted_entries.destroy(Entry.find(params[:id]))
    redirect_to :voted_entries, notice: 'いいねを取り消しました。'
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
