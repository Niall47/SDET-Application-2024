require_relative 'file_handler'
require_relative 'validator'
require 'active_support/inflector'

class DriverRecord
  include Validator
  attr_reader :first_name, :last_name, :date_of_birth, :driver_id, :entitlements

  ENTITLEMENTS = {
    'A' => 'Motorbike',
    'B' => 'Car',
    'C' => 'Lorry',
    'D' => 'Bus'
  }.freeze

  def initialize(last_name:, date_of_birth:, driver_id:, entitlements:, first_name:)
    @first_name = first_name.empty? ? 'X' : first_name
    @last_name = last_name
    @date_of_birth = date_of_birth
    @driver_id = driver_id
    @entitlements = entitlements
  end

  def validate
    Validator.validate_record(record: self)
  end

  def as_csv
    "#{clean_name(last_name)},#{clean_name(first_name)},#{clean_date(date_of_birth)},#{driver_id},#{clean_entitlements(entitlements)}"
  end

  def clean_name(name)
    name.titleize
  end

  def clean_date(date_of_birth)
    Date.parse(date_of_birth).strftime('%d,%b,%Y')
  end

  def clean_entitlements(entitlements)
    entitlements_array = entitlements.scan(/\w+/)
    entitlements_array.map { |letter| ENTITLEMENTS[letter] }
  end
end
