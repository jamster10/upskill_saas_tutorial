
class ContactsController < ApplicationController
  
  #Get request  to /contact-us
  #Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts
  def create
    #Mass assignmetn of form fields into contact object
    @contact = Contact.new(contact_params)
    
    #Save the contact object to DB
    if @contact.save
      #Store form fields via parameters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact Mailer email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Display success message in flash hash and redirect to new action
      flash[:success] = "Message Sent."
      redirect_to new_contact_path
    else
      # If contact object doesnt save 
      #show error messages in flash hash & redirect
      flash[:danger] = @contact.errors.full_messages.join(". ")
      redirect_to new_contact_path
    end
  end
  
  private
  # To collect data from form we need to use strong params
  # and whitelist form fields
  def contact_params
    params.require(:contact).permit(:name, :email, :comments)
  end
end