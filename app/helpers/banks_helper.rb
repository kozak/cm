module BanksHelper
  def banks_chart_data
    AccountBalance.pluck('DISTINCT created_on').map do |date|
      {
        :created_on => date,
        :amount_in_pln => Account.all.map do |account|
          account.balance_for(date).try(:amount_in_pln).to_f
        end.sum.round(2)
      }
    end.to_json
  end
end
