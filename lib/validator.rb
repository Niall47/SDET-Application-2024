require 'date'
class ValidationError < StandardError
  attr_reader :invalid_field, :value

  def initialize(msg = 'Default message', invalid_field:, value:)
    @invalid_field = invalid_field
    @value = value
    super(msg)
  end
end

module Validator
  VALID_ENTITLEMENTS = %w[A B C D].freeze
  NAME_REGEX = /^([A-Za-z]+[-' ]?)*[A-Za-z]*$/.freeze
  DATE_OF_BIRTH_REGEX = /^\d{4}-\d{1,2}-\d{1,2}$/.freeze
  DRIVER_ID_REGEX = /^[a-zA-Z]{5}\d{4}$/.freeze
  FIRST_NAME_PLACEHOLDER = 'X'.freeze

  def self.validate_record(record:)
    unless last_name_valid?(record.last_name)
      raise ValidationError.new 'Invalid last name', invalid_field: 'last_name',
                                                     value: record.last_name
    end
    unless first_name_valid?(record.first_name)
      raise ValidationError.new 'Invalid first name', invalid_field: 'first_name',
                                                      value: record.first_name
    end
    unless date_of_birth_valid?(record.date_of_birth)
      raise ValidationError.new 'Invalid date of birth', invalid_field: 'date_of_birth',
                                                         value: record.date_of_birth
    end
    unless driver_id_valid?(
      driver_id: record.driver_id, first_name: record.first_name, last_name: record.last_name
    )
      raise ValidationError.new 'Invalid driver ID', invalid_field: 'driver_id',
                                                     value: record.driver_id
    end

    return if entitlements_valid?(record.entitlements)

    raise ValidationError.new 'Invalid entitlements', invalid_field: 'entitlements',
                                                      value: record.entitlements
  end

  def self.first_name_valid?(first_name)
    if first_name.match?(NAME_REGEX) || first_name == ''
      true
    else
      false
    end
  end

  def self.last_name_valid?(last_name)
    if !last_name.empty? && last_name.match?(NAME_REGEX)
      true
    else
      false
    end
  end

  def self.date_of_birth_valid?(date_of_birth)
    return false unless date_of_birth
    return false unless date_of_birth.match DATE_OF_BIRTH_REGEX

    begin
      dob = Date.parse date_of_birth
    rescue StandardError
      return false
    end
    return false if dob > Date.today
    return false if dob < Date.today - 100 * 365
    return false if dob > Date.today - 15 * 365

    true
  end

  def self.driver_id_valid?(driver_id:, first_name:, last_name:)
    return false unless driver_id.match DRIVER_ID_REGEX

    first_name = FIRST_NAME_PLACEHOLDER if first_name == ''
    last_name = last_name.ljust(5, FIRST_NAME_PLACEHOLDER) if last_name.length < 4
    return false unless driver_id[0..4] == last_name[0..3].upcase + first_name[0].upcase

    true
  end

  def self.entitlements_valid?(entitlements)
    elements = entitlements.scan(/\w+/)
    elements.each do |element|
      return false unless VALID_ENTITLEMENTS.include? element
    end

    true
  end
end
