require_relative 'file_handler'
require_relative 'validator'
class DriverRecord
  include Validator
  attr_reader :first_name, :last_name, :date_of_birth, :driver_id, :entitlements

  def initialize(last_name:, date_of_birth:, driver_id:, entitlements:, first_name: 'X')
    @first_name = first_name
    @last_name = last_name
    @date_of_birth = date_of_birth
    @driver_id = driver_id
    @entitlements = entitlements
  end

  def validate
    Validator.validate_record(record: self)
  end

  def as_csv
    "#{last_name},#{first_name},#{date_of_birth},#{driver_id},#{entitlements}"
  end
end
