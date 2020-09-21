require 'active_support'
require 'active_support/core_ext'

class RecurringMoment
  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start

    while current <= date
      if current == date
        return true
      end

      if @period == 'monthly'
        current = current.advance(months: @interval)
        while @start.day > current.day && current.end_of_month.day != current.day
          current = current.advance(days: 1)
        end
      elsif @period == 'weekly'
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end

    return false
  end
end
