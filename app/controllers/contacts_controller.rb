class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    
    if @contact.valid?
      flash[:notice] = "Thank you for your message! I'll get back to you soon."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error sending your message. Please check the form and try again."
      redirect_to root_path
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end