class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update(role: :premium)
    flash[:notice] = "Thanks for all the money, #{current_user.email}, your account has been upgraded to Premium."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  class Amount
    @default_amount = 15_00
    def self.default
      @default_amount
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.update(role: :standard)

    # convert downgrading user's wikis to public
    @user.wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end

    if @user.save
      flash[:notice] = "#{current_user.email}, your account has been downgraded to Standard."
      redirect_to root_path
    end
  end

end
