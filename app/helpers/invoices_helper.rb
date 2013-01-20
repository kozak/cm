module InvoicesHelper
  def invoices_chart_data
    @invoices.map do |invoice|
      {
        :created_on => invoice.created_on.strftime('%Y-%m'),
        :total_gross => invoice.total_gross,
        :total_gross_in_pln => invoice.total_gross_in_pln
      }
    end.to_json
  end
end
