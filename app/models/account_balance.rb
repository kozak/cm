class AccountBalance < ActiveRecord::Base
  attr_accessible :created_on, :amount, :account_id

  validates :created_on, presence: true
  validates :amount, presence: true
  validates :account_id, presence: true

  belongs_to :account


  def amount_in_pln
    if account.currency == 'EUR'
      amount * exchange_rate.rate
    else
      amount
    end
  end

  def exchange_rate
    ExchangeRate.get_rate(created_on-1, 'EUR')
  end
end
