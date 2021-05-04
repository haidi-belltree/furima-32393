class CardsController < ApplicationController
  before_action :authenticate_user!

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

  def card_params
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
    params.permit(:card_token).merge(customer_token: @customer.id, user_id: current_user.id)
  end
end
