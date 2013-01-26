class Account < ActiveRecord::Base
  attr_accessible :name, :currency

  belongs_to :bank

  has_many :account_balances, :dependent => :destroy
  has_one :account_balance, order: "created_on desc"

  def to_s
    name
  end
end
