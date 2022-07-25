class Admin::OrderDetailsController < ApplicationController
    def update
        @order_detail=OrderDetail.find(params[:id])
        @order=@order_detail.order
    end
end
