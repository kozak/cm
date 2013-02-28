jQuery ->
  if $("#invoices_chart").data('invoices')
    Morris.Line
      element: 'invoices_chart'
      data: $("#invoices_chart").data('invoices')
      xkey: 'created_on'
      ykeys: ['total_gross']
      labels: ['Salary in PLN']
