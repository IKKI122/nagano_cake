class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end
  
  def confirm
    @cart_items=current_customer.cart_items.all
    @order=current_customer.orders.new
    @order.payment_method=params[:order][:payment_method]
    if params[:order][:address_id]=="0"
      @order.postal_code=current_customer.postal_code
      @order.address=current_customer.address
      @order.name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:address_id]=="1"
      @order.postal_code=Address.find(params[:order][:select_address]).postal_code
      @order.address=Address.find(params[:order][:select_address]).address
      @order.name=Address.find(params[:order][:select_address]).name
    elsif params[:order][:address_id]=="2"
      @order.postal_code=params[:order][:postal_code]
      @order.address=params[:order][:address]
      @order.name=params[:order][:name]
    else
      render :new
    end
  end
  
  def create
   
  end

  def complete
  end

  def index
  end

  def show
  end
  
  private
  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
  
  def address_params
      params.require(:order).permit(:postal_code, :address, :name)
  end
end
