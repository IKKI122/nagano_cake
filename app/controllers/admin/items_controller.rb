class Admin::ItemsController < ApplicationController
  def index
    @item=Item.new
    @items=Item.all
    @genre=@item.genre
  end

  def new
    @item=Item.new
    @genres=Genre.all
  end
  
  def create
    @item=Item.new(item_params)
      if @item.save
        redirect_to admin_item_path(@item.id)
      else
        @items=Item.all
        render :index
      end
  end

  def show
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
  end

  def edit
    @item=Item.find(params[:id])
    @genres=Genre.all
  end
  
  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  private
    def item_params
      params.require(:item).permit(:item_image, :name, :introduction, :genre_id, :price, :is_active)
    end
end
