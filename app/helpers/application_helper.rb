module ApplicationHelper
  def exchange_rate(date = Date.today-1, currency = "EUR")
    @exchange_rate ||= ExchangeRate.get_rate(date, currency)
  end

  def sidebar_calendar
    @sidebar_calendar ||= Calendar.new(params[:date])
  end

  def current_salary
    (sidebar_calendar.worked_days.size * CONFIG['salary_per_day']).to_f
  end

  def current_salary_in_pln
    if exchange_rate.rate
      current_salary * exchange_rate.rate
    end
  end

  # Links helpers

  def link_to_new(url)
    url = [:new, url] unless url.is_a?(Array)
    link_to 'New', url, :class => 'btn btn-primary'
  end

  def link_to_edit(url)
    url = [:edit, url] unless url.is_a?(Array)
    link_to 'Edit', url, :class => 'btn btn-mini'
  end

  def link_to_destroy(url)
    link_to 'Destroy', url, :method => :delete, :data => { :confirm => 'Are you sure?' }, :class => 'btn btn-mini btn-danger'
  end

  def link_to_cancel(url)
    link_to 'Cancel', url, :class => 'btn'
  end
end
