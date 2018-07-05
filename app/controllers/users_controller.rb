class UsersController < ApplicationController
  def new
  end

  def create
  	@api = Moip.new.call
    @uniqueId = SecureRandom.hex
    customer = @api.customer.create(user_json)
    @moipid = customer.id

    card = @api.customer.add_credit_card(@moipid, card_json)
    @ccid = card.credit_card.id

    User.create(
      fullname: params[:user][:fullname],
      email: params[:user][:email],
      ownid: @uniqueId,
      phoneArea: params[:user][:areaCode],
      cpf: params[:user][:cpf],
      phoneNumber: params[:user][:phoneNumber],
      moipid: @moipid,
    )
  end

  private

  def user_json
  {
    ownId: @uniqueId,
      email: params[:user][:email],
      fullname: params[:user][:fullname],
      birthDate: params[:user][:birthDate],
      taxDocument: {
            type: "CPF",
            number: params[:user][:cpf],
        },
      phone: {
        countryCode: "55",
        areaCode: params[:user][:areaCode],
        number: params[:user][:phoneNumber],
      },
    }
  end

  def card_json
    {
       method: "CREDIT_CARD",
       creditCard: {
         expirationMonth: params[:cc][:expirationMonth],
         expirationYear: params[:cc][:expirationYear],
         number: params[:cc][:number],
         cvc: params[:cc][:cvc],
         holder: {
           fullname: params[:user][:fullname],
           birthdate: params[:user][:birthDate],
           taxDocument: {
             type: "CPF",
             number: params[:user][:cpf],
           },
           phone: {
             countryCode: "55",
             areaCode: params[:user][:areaCode],
             number: params[:user][:phoneNumber],
           },
         },
       },
     }
   end
end
