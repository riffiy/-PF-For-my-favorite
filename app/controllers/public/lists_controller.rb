class Public::ListsController < ApplicationController
  # リファクタリング
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  # URL直打ち防止
  before_action :prevent_url, only: [:show, :edit, :update, :destroy]
  
  
  # 空のオブジェクト作成
  def new
    @list = List.new
  end
  
  # 投稿データの保存
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    @list.save
    redirect_to lists_path
  end

  # ログイン中ユーザーのリスト一覧表示
  def index
    @lists = List.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end
  
  # 投稿データのストロングパラメータ
  private

  def list_params
    params.require(:list).permit(:user_id, :image, :goal, :relation, :task, :routine)
  end
  
  def set_list
    @list = List.find(params[:id]) 
  end
  
  def prevent_url
    if @list.user_id != current_user.id
      redirect_to root_path
    end
  end
  
end
