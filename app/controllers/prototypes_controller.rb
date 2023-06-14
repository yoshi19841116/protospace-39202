class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show]

  def index
    @users = User.all
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
      if @prototype.save 
        redirect_to root_path, notice: 'データが保存されました。'
      else
        @prototypes = Prototype.includes(:user).all
        render :new
      end
    end

    def destroy
      prototype = Prototype.find(params[:id])
      prototype.destroy
      redirect_to root_path
    end

    def edit
      unless user_signed_in?
        redirect_to action: :index
      end
    end

    def update
      @prototype = Prototype.find(params[:id])
      if @prototype.update(prototype_params)
        redirect_to prototype_path(@prototype), notice: 'データが更新されました。'
      else
        render :edit
      end
    end
    

    def show
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
    end  

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end