require_relative 'driver'
require_relative 'file_handler'
require_relative 'validator'
require 'logger'
require 'pry'

LOG = Logger.new(STDOUT)
LOG.level = Logger::DEBUG

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

imported_csv.drop(1).each do |record|
  begin
    Validator.validate_record(record:)
  rescue ValidationError => e
    LOG.error "#{e.message} is an invalid #{e.field}"
    invalid_records[e.field.to_sym] << e.message
  rescue StandardError => e
    LOG.error "An error occurred: #{e}"
  end
end

LOG.info "Invalid first_names: #{invalid_records[:first_name].count}"
LOG.info "Invalid last_names: #{invalid_records[:last_name].count}"
LOG.info "Invalid date_of_births: #{invalid_records[:date_of_birth].count}"
LOG.info "Invalid driver_ids: #{invalid_records[:driver_id].count}"
LOG.info "Invalid entitlements: #{invalid_records[:entitlements].count}"


#TODO  Next we need to output the number of invalid and valid records then save the valid ones out to a new file