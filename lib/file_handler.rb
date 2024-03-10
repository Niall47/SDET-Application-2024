require 'csv'
module FileHandler
  def self.load_file(filename)
    CSV.read(filename)
  end

  def self.save_to_file(filename: 'default', file: )
    # This needs to handle 'file' being either a hash or an array
    # it should convert it to a csv and save it to the filename
    File.open(filename, 'w') do |f|
      file.each do |record|
        f.puts record
      end
    end
  end
end
