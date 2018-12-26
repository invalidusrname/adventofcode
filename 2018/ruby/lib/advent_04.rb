require 'date'

class SleepAnalyzer
  attr_reader :timesheet, :counts

  def initialize(records)
    @records = records
    @timesheet = {}
    @counts = {}
  end

  def process
    data = {}

    @records.each do |line|
      h = parse_line(line)
      timestamp = h[:datetime].to_time.to_i
      data[timestamp] = h
    end

    dates = data.sort_by { |key, _value| key }

    start_date = dates.first[1][:datetime].to_date
    end_date = dates.last[1][:datetime].to_date

    current_guard = nil
    currently_sleeping = 0

    (start_date..end_date).each do |date|
      [0, 23].each do |h|
        (0..59).each do |m|
          dt = DateTime.new(date.year, date.month, date.mday, h, m, 0)
          timestamp = dt.to_time.to_i
          # puts "#{dt.to_s} -- #{timestamp} #{data.has_key?(timestamp)}"

          if data.key?(timestamp)
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

    calculate_counts
  end

  def calculate_counts
    timesheet.each do |timestamp, ts|
      minute = DateTime.strptime(timestamp.to_s, '%s').min
      guard_id = ts[0]
      asleep = ts[1]

      counts[guard_id] = {} if counts.key?(guard_id) == false

      if counts[guard_id].key?(minute) == false
        counts[guard_id][minute] = asleep
      else
        counts[guard_id][minute] += asleep
      end
    end
  end

  def sleepiest_guard
    counts.max_by do |k, _v|
      sum = 0
      counts[k].each do |_k, amount|
        sum += amount
      end
      sum
    end[0]
  end

  def preferred_minute(guard_id)
    h = counts[guard_id]

    h.max_by { |_k, v| v }[0]
  end

  def preferred_minute_total(guard_id)
    h = counts[guard_id]

    h.max_by { |_k, v| v }[1]
  end

  def part_1
    guard_id = sleepiest_guard
    min = preferred_minute(guard_id)

    guard_id * min
  end

  def part_2
    totals = counts.keys.compact.map do |guard_id, _val|
      minute = preferred_minute(guard_id)
      total = preferred_minute_total(guard_id)

      [guard_id, minute, total]
    end

    winner = totals.max_by { |a| a[2] }

    winner[0] * winner[1]
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
