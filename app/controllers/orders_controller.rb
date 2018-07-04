class OrdersController < ApplicationController
  def new
  end

  def create
    @api ||= Moip.new.call
    @order = @api.order.create(order_json)
  end

  private

  def order_json
    {
      ownId: params[:order][:ownId],
      amount: {
        currency: 'BRL',
        subtotals: {
          shipping: 1500
        }
      },
      items: [
        {
          product: params[:order][:product],
          category: 'OTHER_CATEGORIES',
          quantity: 1,
          detail: 'Evento, 2018',
          price: 10000
        }
      ],
        customer: {
        ownId: params[:order][:customerOwnId],
        fullname: params[:order][:customerFullName],
        email: params[:order][:customerEmail],
        taxDocument: {
          type: 'CPF',
          number: '11122233344'
        },
        phone: {
          countryCode: '55',
          areaCode: '11',
          number: '55555555'
        },
        shippingAddress: {
          street: 'Avenida 23 de Maio',
          streetNumber: 654,
          city: 'Sao Paulo',
          district: 'Centro',
          state: 'SP',
          country: 'BRA',
          zipCode: '01244500'
        }
      }
    }
  end
end
