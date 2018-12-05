require 'date'

class SleepAnalyzer

  def initialize(records)
    @records = records
  end

  def process
    data = {}

    @records.each do |line|
      h = parse_line(line)
      timestamp = h[:datetime].to_time.to_i
      data[timestamp] = h
    end

    dates = data.sort_by {|key, value| key }

    start_date = dates.first[1][:datetime].to_date
    end_date = dates.last[1][:datetime].to_date

    timesheet = {}
    current_guard = nil
    currently_sleeping = 0

    (start_date..end_date).each do |date|
      [0, 23].each do |h|
        (0..59).each do |m|
          dt = DateTime.new(date.year, date.month, date.mday, h, m, 0)
          timestamp = dt.to_time.to_i
          #puts "#{dt.to_s} -- #{timestamp} #{data.has_key?(timestamp)}"

          if data.has_key?(timestamp)
            d = data[timestamp]

            if d[:guard_id]
              current_guard = d[:guard_id]
              currently_sleeping = 0
            end

            if d[:text].include?('sleep')
              currently_sleeping = 1
            elsif d[:text].include?('wake')
              currently_sleeping = 0
            end

          end

          timesheet[timestamp] = [current_guard, currently_sleeping]
        end

      end
    end

    counts = {}

    timesheet.each do |timestamp, ts|
      minute = DateTime.strptime(timestamp.to_s,'%s').min
      guard_id = ts[0]
      asleep = ts[1]

      if counts.has_key?(guard_id) == false
        counts[guard_id] = {'total' => 0}
      end

      counts[guard_id]['total'] += asleep

      if counts[guard_id].has_key?(minute) == false
        counts[guard_id][minute] = asleep
      else
        counts[guard_id][minute] += asleep
      end
    end

    guard_id = counts.max_by { |k,v| counts[k]['total'] }[0]

    h = counts[guard_id]
    h.delete('total')

    preferred_minute = h.max_by { |k,v| v }[0]

    guard_id * preferred_minute
  end

  def parse_line(line)
    regex = /\[(\d{4})-(\d{2}-\d{2}) (\d{2}:\d{2})\]\s(Guard #(\d+))?(.*)/
    m = regex.match(line)
    s = "#{m[1]}-#{m[2]}T#{m[3]}+00:00"

    datetime = DateTime.parse(s)
    guard_id = m[5] ? m[5].to_i : nil
    text = m[6]

    {
      minute: datetime.min,
      datetime: datetime,
      guard_id: guard_id,
      text: text,
      awake: true,
    }
  end
end
