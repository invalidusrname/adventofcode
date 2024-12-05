class Muller
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def pieces
    data.scan(/mul\(\d{1,3},\d{1,3}\)/)
  end

  def uncorrupted_pieces
    matches = data.scan(/(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/)

    process = true
    uncorrupted = []

    matches.each do |m|
      process = true if m[1]
      process = false if m[2]
      uncorrupted << m[0] if m[0] && process
    end

    uncorrupted
  end

  def process_piece(str)
    splits = str.tr("^0123456789,", "").split(",")

    splits[0].to_i * splits[1].to_i
  end

  def mull
    pieces.sum { |str| process_piece(str) }
  end

  def uncorrupted_mull
    uncorrupted_pieces.sum { |str| process_piece(str) }
  end
end
