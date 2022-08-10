class Public::CustomersController < ApplicationController
  def show
    @customer=current_customer
  end

  def edit
    @customer=current_customer
  end
  
  def update
    @customer=current_customer
    if @customer.update(customer_params)
      flash[:notice]="登録情報を更新しました。"
      redirect_to show_path
    else
      render :edit
    end
  end

  def unsubscribe
  end
  
  def withdraw
    @customer=current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash.now[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end
  
  private
  def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
