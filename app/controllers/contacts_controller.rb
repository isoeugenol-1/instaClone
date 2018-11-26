class ContactsController < ApplicationController
  include ApplicationHelper
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.email = current_user.email
    @contact.name = current_user.name
   
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver  ##追記
      redirect_to @contact, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
        redirect_to @contact, notice: 'Contact was successfully updated.'
    else
        render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: 'Contact was successfully destroyed.'
  end

  private
  
  def set_contact
      @contact = Contact.find(params[:id])
  end

  def contact_params
      params.require(:contact).permit(:name, :email, :content)
  end
end
