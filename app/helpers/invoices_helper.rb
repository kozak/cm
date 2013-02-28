module InvoicesHelper
  def invoices_chart_data
    @invoices.group_by{|invoice| invoice.created_on.strftime('%Y-%m') }.map do |date, invoices|
      {
        :created_on => date,
        :total_gross => invoices.sum(&:total_gross_in_pln)
      }
    end.to_json
  end
end
