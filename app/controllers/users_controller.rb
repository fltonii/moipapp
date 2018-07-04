class UsersController < ApplicationController
  def new
  end

  def create
	api = Moip.new.call
  uniqueId = SecureRandom.hex
  customer = api.customer.create(
  		ownId: uniqueId,
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

    )

    @moipid = customer.id

    card = api.customer.add_credit_card(@moipid, {
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
     })
     @ccid = card.credit_card.id

     User.create(moipid: @moipid, ccid: @ccid)
  end
end
