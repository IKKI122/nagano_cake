class Admin::OrdersController < ApplicationController
  def index
    @orders=Order.all
  end
  
  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
  end
  
  def update
    @order=Order.find(params[:id])
    @order_details=@order.order_details
    @order.update(order_params)
    if @order.status=='paid_up' 
	     @order_details.update_all(making_status: 'waiting') 
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :status, :customer_id)
  end
end
