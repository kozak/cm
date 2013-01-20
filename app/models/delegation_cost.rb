class DelegationCost < ActiveRecord::Base
  attr_accessible :amount, :delegation_id, :name, :number

  belongs_to :delegation

  validates :number, :presence => true
  validates :amount, :presence => true
  validates :name, :presence => true

  def total_amount
    (amount * number).round(2)
  end
end
