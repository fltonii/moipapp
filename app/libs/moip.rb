class Moip
  attr_reader :token, :key

  def initialize(token = nil, key = nil)
    @token = token || get_token
    @key = key || get_key
  end

  def call
    authentication
  end

  private

  def get_token
    '9VKSNKLBIBZOMTMM7WQB2Y5DTJ1PFHSO'
  end

  def get_key
    'N25YUMRXFG8XLAQDFN2X1BB1GYT0CNACHZEF62RV'
  end


  def authentication
    Moip2::Api.new(moip_client)
  end

  def moip_client
    Moip2::Client.new(:sandbox, moip_auth)
  end

  def moip_auth
    @auth = Moip2::Auth::Basic.new(token, key)
  end
end
