class ContactsController < ApplicationController
  def index
    @contact = Contact.new
    render :index
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :confirm
    else
      render :index
    end
  end

  def thanks
    @contact = Contact.new(require_contact_params)
    ContactsMailer.received_email(@contact).deliver

    render :thanks
  end

  private
  def contact_params
    params.permit(:contact_name, :contact_email, :contact_email_confirmation, :contact_comment)
  end

  def require_contact_params
    params.require(:contact).permit(:contact_name, :contact_email, :contact_email_confirmation, :contact_comment)
  end
end
