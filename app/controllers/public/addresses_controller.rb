class Public::AddressesController < ApplicationController
  def index
    @address=Address.new
    @addresses=current_customer.addresses.all
  end

  def edit
    @address=Address.find(params[:id])
  end
  
  def create
    @address=Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @addresses=current_customer.addresses.all
      flash.now[:alert]="情報を入力してください。"
      render :index
    end
  end
  
  def update
    @address=Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      flash.now[:alert]="情報を入力してください。"
      render :edit
    end
  end
  
  def destroy
    @address=Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private
  def address_params
      params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end