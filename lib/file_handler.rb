require 'csv'
module FileHandler
  REQUIRED_HEADERS = %w[lastName firstName dateOfBirth driverID entitlements].freeze
  def self.load_file(filename)
    file = CSV.read(filename)
    raise 'Invalid headers' unless file.first == REQUIRED_HEADERS

    file.drop(1)
  end


  def self.save_to_file(filename: 'default', file: )
    File.open(filename, 'w') do |f|
      f.puts REQUIRED_HEADERS.join(',')
      file.each do |record|
        f.puts record.as_csv
      end
    end
  end
end

