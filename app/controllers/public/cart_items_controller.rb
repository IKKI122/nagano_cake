class Public::CartItemsController < ApplicationController
  def index
    @cart_item=CartItem.new
    @cart_items=current_customer.cart_items.all
    @item=@cart_item.item
    @total_price=0
  end
  
  def update
    @cart_item=CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item=CartItem.find(params[:id])
    @cart_item.destroy
    flash[:alert]="商品を削除しました"
    redirect_to cart_items_path
  end
  
  def destroy_all
    CartItem.destroy_all
    flash[:alert]="商品を全て削除しました"
    redirect_to cart_items_path
  end
  
  def create
    @cart_item=CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
    	cart_item=current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    	cart_item.amount+=params[:cart_item][:amount].to_i
    	flash[:notice]="商品を追加しました"
    	cart_item.save
    	redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice]="商品を追加しました"
      redirect_to cart_items_path
    else
      flash[:alert]="個数を選択してください"
      redirect_to item_path(params[:cart_item][:item_id])
    end
  end
  
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
