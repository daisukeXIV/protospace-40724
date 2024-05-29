class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new ,:edit ,:destroy]
  before_action :set_prototype, only:[:edit,:update,:show,:destroy]
  def index
    @prototypes = Prototype.all
    
  end
  def new
    @prototype= Prototype.new
  
  end
  def create
    @prototype= Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
  def update

    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end

  end
  def show

    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  def destroy

    @prototype.destroy
    redirect_to root_path
  end
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  private


  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
end
