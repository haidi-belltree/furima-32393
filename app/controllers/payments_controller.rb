class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :if_current_user
  before_action :sold_out
  before_action :payment_new, only: [:new, :order_new]
  before_action :unless_card_present, only: [:order_new, :order_create, :choice]

  def new
  end

  def create
    @payment_place = PaymentPlace.new(payment_params)
    if @payment_place.valid?
      pay_by_card_method
      @payment_place.save
      redirect_to root_path
    else
      render action: :new
    end
  end

 # 登録したクレジットカードでの購入

  def choice
  end

  def order_new
  end

  def order_create
    set_order_method
    @payment_place = PaymentPlace.new(order_params)
    if @payment_place.valid?
      pay_order_method
      @payment_place.save
      redirect_to root_path
    else
      render action: :order_new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def if_current_user
    redirect_to root_path if current_user.id == @item.user.id
  end

  def sold_out
    @payments = @item.payment 
    redirect_to root_path unless @payments.nil?
  end

  def payment_new
    @payment_place = PaymentPlace.new
  end

  def payment_params
    params.require(:payment_place).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, item_price: @item.price, token: params[:token]
    )
  end

  def pay_by_card_method
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: payment_params[:item_price],
      card: payment_params[:token],
      currency: 'jpy'
    )
  end

 # 登録したクレジットカードでの購入

 def unless_card_present
  redirect_to new_item_payment_path(@item.id) unless current_user.card.present?
 end

 def set_order_method
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  @customer_token = current_user.card.customer_token
 end

 def order_params
  params.require(:payment_place).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(
    user_id: current_user.id, item_id: @item.id, item_price: @item.price, token: @customer_token
  )
 end

 def pay_order_method
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: order_params[:item_price],
    customer: order_params[:token],
    currency: 'jpy'
  )
 end

end
