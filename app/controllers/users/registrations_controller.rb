class Users::RegistrationsController < Devise::RegistrationsController
  def create
    
    #Extend default Devise gem behaviour so that users wil
    #Pro accout (2) Save with a special subscription
    #otherwise Devise signs them up as usual
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id==2
          resource.save_withsubscription
        else
          resource.save
        end
      end  
    end
  end
end