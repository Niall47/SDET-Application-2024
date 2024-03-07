require_relative 'file_handler'
class Driver

  def initialise(first_name: 'X', last_name:, date_of_birth:, driver_id:, entitlements:)
    @first_name = first_name
    @last_name = last_name
    @date_of_birth = date_of_birth
    @driver_id = driver_id
    @entitlements = entitlements
  end

end
# file = FileHandler.load_file('db/drivers.csv')
# binding.pry
# puts file.methods