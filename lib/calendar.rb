class Calendar
  attr_reader :date

  def initialize(date)
    @date = Date.parse(date) rescue Date.today
  end

  def start_date
    date.beginning_of_month
  end

  def end_date
    date.end_of_month
  end

  def weeks
    (start_date.beginning_of_week..end_date.end_of_week).to_a.in_groups_of(7)
  end

  def working_days
    @working_days ||= (start_date..end_date).to_a.delete_if{ |date| [6,7].include?(date.cwday) }
  end

  def vacations
    @vacations ||= Day.vacations(start_date, end_date)
  end

  def worked_days
    @worked_days ||= working_days - vacations.map(&:first)
  end

  def css_classes(date)
    classes = []
    classes << 'na' if date.month != start_date.month || [6,7].include?(date.cwday)
    classes << 'current' if date == Date.today
    classes << 'dayoff' if vacations[date]
    classes.join(' ')
  end
end
