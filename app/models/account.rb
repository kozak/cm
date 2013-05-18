class Account < ActiveRecord::Base
  attr_accessible :name, :currency

  belongs_to :bank

  has_many :account_balances, :dependent => :destroy
  has_one :account_balance, order: "created_on desc"

  def to_s
    name
  end

  def balance_for(date)
    account_balances.where('created_on <= ?', date).last
  end

  def empty?
    !account_balance || account_balance.amount.zero?
  end
end
