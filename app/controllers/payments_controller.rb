class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :if_current_user

  def new
    @payment_place = PaymentPlace.new
  end

  def create  
    @payment_place = PaymentPlace.new(payment_params)
    if @payment_place.valid?
      @payment_place.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def payment_params
    params.require(:payment_place).permit(:post_code, :prefecture_id, :city, 
                                          :block, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def if_current_user
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

end
