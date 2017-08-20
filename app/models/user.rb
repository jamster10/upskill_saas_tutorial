class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
         
  attr_accessor :stripe_card_token       
  #If user pass validations (email etc) then call stripe and 
  #tell stripe to set up subscription upon charging their card
  # Stripe responds with customer data
  #Store customer id as the customer token
  def save_withsubscription
    if valid?
     customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
     self.stripe_card_token = customer.id
     save!
    end
  end
end
