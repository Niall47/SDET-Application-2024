require 'csv'
module FileHandler
  def self.load_file(filename)
    CSV.read(filename)
  end

  def self.save_to_file(filename: 'default', file: )
    File.write(filename, file.to_csv)
  end
end
