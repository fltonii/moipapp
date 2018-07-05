class OrdersController < ApplicationController
  def new
  end

  def create
    @api ||= Moip.new.call
    @order = @api.order.create(order_json)
    @payment = @api.payment.create(@order.id, payment_json)
  end

  private

  def order_json
    user = User.last
    uniqueId = SecureRandom.hex
    {
      ownId: uniqueId,
      amount: {
        currency: 'BRL',
        subtotals: {
          shipping: 0
        }
      },
      items: [
        {
          product: 'recarga',
          category: 'OTHER_CATEGORIES',
          quantity: 1,
          price: params[:order][:amout].to_i*100,
        }
      ],
        customer: {
        ownId: user.ownid,
        fullname: user.fullname,
        email: user.email,
        taxDocument: {
          type: 'CPF',
          number: user.cpf,
        },
        phone: {
          countryCode: '55',
          areaCode: user.phoneArea,
          number: user.phoneNumber,
        },
        shippingAddress: {
          street: 'Avenida 23 de Maio',
          streetNumber: 654,
          city: 'Sao Paulo',
          district: 'Centro',
          state: 'SP',
          country: 'BRA',
          zipCode: '01244500',
        }
      }
    }
  end

  def payment_json
    {
      installment_count: 1,
      funding_instrument: {
        credit_card: {
          id: @order.customer.funding_instrument.credit_card.id,
          brand: @order.customer.funding_instrument.credit_card.brand,
          first6: @order.customer.funding_instrument.credit_card.first6,
          last4: @order.customer.funding_instrument.credit_card.last4,
          store: @order.customer.funding_instrument.credit_card.store,
          cvc: 123,
        },
        method: 'CREDIT_CARD',
      }
    }
  end
end

# @order.customer.funding_instrument
