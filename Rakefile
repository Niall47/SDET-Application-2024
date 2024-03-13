# frozen_string_literal: true

require_relative 'lib/driver'
require_relative 'lib/file_handler'
require_relative 'lib/validator'
require 'logger'

LOG = Logger.new(STDOUT)
LOG.datetime_format = '%H:%M:%S'
LOG.level = Logger::DEBUG
# LOG.level = Logger::INFO

desc 'Load driver records and output the number of invalid records'
task :validate do
  invalid_records = {
    first_name: [],
    last_name: [],
    date_of_birth: [],
    driver_id: [],
    entitlements: []
  }

  filename = 'db/drivers.csv'
  LOG.info "Loading drivers from #{filename}"
  imported_csv = FileHandler.load_file(filename)
  LOG.info "#{imported_csv.count} records loaded"
  records = imported_csv.map do |record|
    DriverRecord.new(
      last_name: record[0],
      first_name: record[1],
      date_of_birth: record[2],
      driver_id: record[3],
      entitlements: record[4]
    )
  end

  records.each do |record|
    record.validate
  rescue ValidationError => e
    LOG.debug "#{e.value} was an invalid #{e.invalid_field} - #{record.inspect}"
    invalid_records[e.invalid_field.to_sym] << record
  rescue StandardError => e
    LOG.error "Unexpected error occurred: #{e}"
  end

  LOG.info "Invalid first_names: #{invalid_records[:first_name].count}"
  LOG.info "Invalid last_names: #{invalid_records[:last_name].count}"
  LOG.info "Invalid date_of_births: #{invalid_records[:date_of_birth].count}"
  LOG.info "Invalid driver_ids: #{invalid_records[:driver_id].count}"
  LOG.info "Invalid entitlements: #{invalid_records[:entitlements].count}"
  LOG.info "Total invalid records: #{invalid_records.values.flatten.count} / #{imported_csv.count} records"
  LOG.info "Total valid records: #{imported_csv.count - invalid_records.values.flatten.count} / #{imported_csv.count} records"
end

desc 'Load driver records and output files with valid and invalid records'
task :sort do
  valid_records = []
  invalid_records = []

  filename = 'db/drivers.csv'
  LOG.info "Loading drivers from #{filename}"
  imported_csv = FileHandler.load_file(filename)
  LOG.info "#{imported_csv.count} records loaded"
  records = imported_csv.map do |record|
    DriverRecord.new(
      last_name: record[0],
      first_name: record[1],
      date_of_birth: record[2],
      driver_id: record[3],
      entitlements: record[4]
    )
  end

  records.each do |record|
    record.validate
    valid_records << record
  rescue ValidationError => e
    error = "#{e.value} was an invalid #{e.invalid_field}"
    LOG.debug "#{error} #{record.inspect}"
    invalid_records << record
  rescue StandardError => e
    LOG.error "Unexpected error occurred: #{e}"
  end

  FileHandler.save_to_file(filename: 'db/valid_records.csv', file: valid_records)
  LOG.info "#{valid_records.count} out of #{records.count} valid records saved to db/valid_records.csv"
end
