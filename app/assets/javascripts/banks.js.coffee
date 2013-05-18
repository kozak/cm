jQuery ->
  if $("#banks_chart").data('invoices')
    Morris.Line
      element: 'banks_chart'
      data: $("#banks_chart").data('invoices')
      xkey: 'created_on'
      ykeys: ['amount_in_pln']
      labels: ['Money in PLN']
