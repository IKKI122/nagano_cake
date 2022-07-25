class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end
  
  def confirm
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    @total_price=0
    @order.shipping_cost=800
    @cart_items=current_customer.cart_items
    @order.payment_method=params[:order][:payment_method]
    if params[:order][:select_address]=="0"
      @order.postal_code=current_customer.postal_code
      @order.address=current_customer.address
      @order.name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address]=="1"
      @address=Address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
    elsif params[:order][:select_address]=="2"
      @address=current_customer.addresses.new
      @address.postal_code=params[:order][:postal_code]
      @address.address=params[:order][:address]
      @address.name=params[:order][:name]
      @address.customer_id=current_customer.id
      if @address.save
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
      else
        render :new
      end
    end
  end
  
  def create
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    @order.shipping_cost=800
    if @order.save
      @cart_items=current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_detail=OrderDetail.new 
        @order_detail.item_id=cart_item.item_id 
        @order_detail.order_id=@order.id
        @order_detail.amount=cart_item.amount 
        @order_detail.price=(cart_item.item.price * 1.1).floor 
        @order_detail.making_status=0
        @order_detail.save
      end  
        @cart_items.destroy_all
        redirect_to complete_path
    else
      render :new
    end
  end

  def complete
  end

  def index
    @orders=current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
  end
  
  private
  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
  
  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end
end
