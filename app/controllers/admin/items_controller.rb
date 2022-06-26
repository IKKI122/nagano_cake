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
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  private
  def item_params
    params.require(:item).permit(:image_id, :name, :introduction, :genre_id, :price, :is_active)  
  end
end
