class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :unless_current_user

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def unless_current_user
    redirect_to root_path unless current_user.id == @user.id
  end

  def card_params
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
    params.permit(:card_token).merge(customer_token: @customer.id, user_id: current_user.id)
  end
end
