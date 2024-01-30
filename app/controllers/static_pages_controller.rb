class StaticPagesController < ApplicationController
  def contact
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :confirm
    else
      render :contact
    end
  end

  def done
    @contact = Contact.new(contact_params)
    if params[:back]
      render :contact
    else
      ContactMailer.send_mail(@contact).deliver_now
      render :done
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
