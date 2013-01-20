jQuery ->
  if $("#invoices_chart").data('invoices')
    Morris.Line
      element: 'invoices_chart'
      data: $("#invoices_chart").data('invoices')
      xkey: 'created_on'
      ykeys: ['total_gross_in_pln', 'total_gross']
      labels: ['Salary in PLN', 'Salary in EUR']
