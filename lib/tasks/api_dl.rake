require 'json'
require 'rest-client'
require 'byebug'

ERGAST_API_F1 = 'http://ergast.com/api/f1/'

# Use this rake task to retrieve the circuits for a given season to the schema and to load seed data
namespace :api_dl do
  desc 'This should be run in development only'
  task :dev_only do
    fail 'This task can only be run in the development environment' unless Rails.env.development?
  end

  task :dl_f1data,[:season] => [:environment] do |t, args|
    retrieve_circuits(args.season)
    retrieve_rounds(args.season)
    # retrieve_drivers(args.season)
    # retrieve_constructors(args.season)
  end

  def retrieve_circuits(season)
    puts 'Making API call to Ergast F1 to get Circuits'
    rest_data = RestClient.get("http://ergast.com/api/f1/#{season}/circuits.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing Circuits'
    process_circuits(json_data['MRData'])
  end

    def retrieve_rounds(season)
    puts 'Making API call to Ergast F1 to get Round details'
    rest_data = RestClient.get("http://ergast.com/api/f1/#{season}.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing Rounds'
    byebug
    process_rounds(json_data['MRData'])
  end

  def retrieve_drivers(season)
    puts 'Making API call to Ergast F1 to get Drivers'
    rest_data = RestClient.get(ERGAST_API_F1"#{season}/drivers.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing'
    puts json_data
    # TODO: process_drivers(json_data['MRData'])
  end

  def retrieve_constructors(season)
    puts 'Making API call to Ergast F1 to get Drivers'
    rest_data = RestClient.get(ERGAST_API_F1"#{season}/constructors.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing'
    puts json_data
    # TODO: process_constructors(json_data['MRData'])
  end

  def process_circuits(feeds)
    circuit_table = feeds['CircuitTable']
    circuits = circuit_table['Circuits']

    circuits.each do |circuit|
      location = circuit['Location']
      seed_circuits(circuit['circuitId'],circuit['circuitName'], location['locality'], location['country'])
    end
  end

  def seed_circuits(code, name, locailty, country)
    Circuit.create(ergast_circuit_code: code,
                   name: name,
                   locality: locailty,
                   country: country)
  end

  def process_rounds(feeds)
    race_table = feeds['RaceTable']
    races = race_table['Races']

    races.each do |race|

      circuit_id = get_circuit_id(race['Circuit'])
      # TODO: qly_datetime = calculate_qly_datetime(race['date'], race['time'])
      # TODO: race_datetime = calculate_race_datetime(race['date'], race['time'])
      # TODO: seed_rounds(race['round'], circuit_id, qly_datetime, race_datetime)
      seed_rounds(race['round'], circuit_id, race['date'], race['time'], race['date'], race['time'])
    end

  end

  def seed_rounds(round_no, circuit_id, qly_date, qly_time, race_date, race_time)
    Round.create(round_number: round_no,
                  circuit_id: circuit_id,
                  qly_date: qly_date,
                  qly_time: qly_time,
                  race_date: race_date,
                  race_time: race_time )
  end

  private

  def get_circuit_id(circuit_feed)

    circuits = Circuit.where(ergast_circuit_code: circuit_feed['circuitId'])
    circuits.ids.first
  end

end