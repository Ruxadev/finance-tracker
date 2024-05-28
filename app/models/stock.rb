class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
                                  endpoint: 'https://cloud.iexapis.com/v1')
    begin
      company_name = client.company(ticker_symbol).company_name
      last_price = client.price(ticker_symbol)
      puts "Company Name: #{company_name}, Last Price: #{last_price}" # Debug statement
      new(ticker: ticker_symbol, name: company_name, last_price: last_price)
    rescue => exception
      puts "Error fetching stock information: #{exception.message}" # Debug statement
      return nil
    end
  end

end
