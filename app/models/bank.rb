class Bank < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :accounts

  def to_s
    name
  end

  def total_amount
    accounts.map(&:account_balance).sum(&:amount_in_pln)
  end
end
