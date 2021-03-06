# require 'json'
# require 'rest-client'
# require 'byebug'
# require 'Date'

ERGAST_API_F1 = 'http://ergast.com/api/f1/'

# Use this rake task to retrieve the circuits for a given season to the schema and to load seed data
namespace :api_dl do

  task :dl_f1data, [:season] => [:environment] do |t, args|
    retrieve_circuits(args.season)
    retrieve_rounds(args.season)
    retrieve_constructors(args.season)
    retrieve_drivers(args.season)
    retrieve_results_to_date(args.season)
  end

  def retrieve_circuits(season)
    puts 'Making API call to Ergast F1 to get Circuits'
    rest_data = RestClient.get("#{ERGAST_API_F1}#{season}/circuits.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing Circuits'
    # TODO: SDP: Try and keep functions which call each other close by, makes reading the code
    # easier
    process_circuits(json_data['MRData'])
  end

    def retrieve_rounds(season)
    puts 'Making API call to Ergast F1 to get Round details'
    rest_data = RestClient.get("#{ERGAST_API_F1}#{season}.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing Rounds'
    process_rounds(json_data['MRData'])
  end

  def retrieve_constructors(season)
    puts 'Making API call to Ergast F1 to get Constructors'

    # TODO: SDP: This pattern of RESTClient.get & JSON.parse is repeated a lot, so a very
    # good candidate for placing into a function of it's own, making the code more
    # readable
    rest_data = RestClient.get("#{ERGAST_API_F1}#{season}/constructors.json")
    json_data = JSON.parse(rest_data)
    puts 'Processing'
    process_constructors(json_data['MRData'])
  end

    def retrieve_drivers(season)
    # retrieve drivers by constructor
    constructors = Constructor.all
    constructors.each do |constructor|
      puts 'Making API call to Ergast F1 to get Drivers by constructor'
      rest_data = RestClient.get("#{ERGAST_API_F1}#{season}/constructors/#{constructor.ergast_constructor_code}/drivers.json")
      json_data = JSON.parse(rest_data)
      puts 'Processing'
      process_drivers(json_data['MRData'])
    end
  end

  def retrieve_results_to_date(season)
    # Get all the number of races to date
    rounds = Round.where(["race_datetime < ?", DateTime.now]).count

    # For each race let's do an API call to get all the races to date.
    rounds.times do |n|
      puts 'Making API call to Ergast F1 to get Rounds Result'
      rest_data = RestClient.get("#{ERGAST_API_F1}#{season}/#{n+1}/results.json?limit=50")
      json_data = JSON.parse(rest_data)
      puts 'Processing'
      process_round_results(json_data['MRData'])
    end
  end

  def process_circuits(feeds)
    # TODO: SDP: Okay to just write curcuits = feeds['CircuitTable']['Circuits']
    circuit_table = feeds['CircuitTable']
    circuits = circuit_table['Circuits']

    circuits.each do |circuit|
      location = circuit['Location']
      seed_circuits(circuit['circuitId'],circuit['circuitName'], location['locality'], location['country'])
    end
  end

  # TODO: SDP: Not quite sure why this is in a method on it's own?
  # Better having all this functionality in process_circuits
  def seed_circuits(code, name, locailty, country)
    Circuit.create(ergast_circuit_code: code,
                   name: name,
                   locality: locailty,
                   country: country)
  end

  def process_rounds(feeds)
    # TODO: SDP: Again better in one line races = feeds['RaceTable']['Races']
    race_table = feeds['RaceTable']
    races = race_table['Races']

    races.each do |race|
      # TODO: SDP: Perhaps you should use Rubocop, it will help you structure your code in a consistent fashion
      # for maximum legibility
      circuit_id = get_circuit_id(race['Circuit'])
      race_datetime = calculate_race_datetime(race['date'], race['time'])

      qly_datetime = calculate_qly_datetime(race_datetime,race['Circuit'])
      seed_rounds(race['round'], circuit_id, qly_datetime, race_datetime, 0,0)
    end
  end

  # TODO: SDP: 1 line functions usually race question marks in my mind
  def seed_rounds(round_no, circuit_id, qly_datetime, race_datetime, qly_results_id, race_results_id)
    Round.create(round_number: round_no,
                  circuit_id: circuit_id,
                  qly_datetime: qly_datetime,
                  race_datetime: race_datetime )
  end

  def process_drivers(drivers_feed)
    driver_table = drivers_feed['DriverTable']
    constructor_id = get_constructor_id(driver_table)
    drivers = driver_table['Drivers']
    drivers.each do |driver|
      id = driver['driverId']
      code = driver['code']
      # TODO: Fix this so it's more rubyist and less java-ist.
      name = driver['givenName'] + ' ' + driver['familyName']
      number = driver['permanentNumber']
      seed_driver(id, code, name, number, constructor_id)
    end
  end

  def seed_driver(id, code, name, number, constructor_id)
    Driver.create(ergast_driver_id: id,
                  ergast_driver_code: code,
                  name: name,
                  number: number,
                  constructor_id: constructor_id)
  end

  def process_constructors(constructors_feed)
    constructors_table = constructors_feed['ConstructorTable']
    constructors = constructors_table['Constructors']
    constructors.each do |constructor|
      seed_constructor(constructor['constructorId'], constructor['name'], constructor['nationality'])
    end
  end

  # TODO: SDP: Again, a 1 line function strikes me as being redundant
  def seed_constructor(code, name, nationality)
    Constructor.create(ergast_constructor_code: code,
                        name: name,
                        nationality: nationality)
  end

  # TODO: SDP: I found this function hard to read, especially because of the hash keys
  # look like magic keys. What does race_result["8"]
  def process_round_results(results_feed)
    race_table = results_feed['RaceTable']
    races = race_table['Races']
    round = race_table['round']
    race = races.first
    finishers = race['Results']
    race_result = {}
    qly_result = {}

    finishers.each do |finisher|
      driver = finisher['Driver']
        if finisher['position'].to_i <= 10
          race_result[finisher['position']] = get_driver_id(driver)
        end

        if finisher['grid'].to_i <= 3
          qly_result[finisher['grid']] = get_driver_id(driver)
        end
    end

    seed_race_result(round, race_result["1"], race_result["2"], race_result["3"],
                                      race_result["4"], race_result["5"], race_result["6"],
                                      race_result["7"], race_result["8"], race_result["9"],
                                      race_result["10"])
    seed_qly_result(round, qly_result["1"], qly_result["2"], qly_result["3"])
  end

  def seed_race_result(round, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth)
    RaceResult.create(round_id: round,
                      race_result_1: first,
                      race_result_2: second,
                      race_result_3: third,
                      race_result_4: fourth,
                      race_result_5: fifth,
                      race_result_6: sixth,
                      race_result_7: seventh,
                      race_result_8: eighth,
                      race_result_9: ninth,
                      race_result_10: tenth)
  end

  def seed_qly_result(round, first, second, third)
        QlyResult.create(round_id: round,
                      qly_result_1: first,
                      qly_result_2: second,
                      qly_result_3: third)
  end

  def get_circuit_id(circuit_feed)
    Circuit.find_by_ergast_circuit_code(circuit_feed['circuitId']).id
  end

  def get_constructor_id(constructor_feed)
    Constructor.find_by_ergast_constructor_code(constructor_feed['constructorId']).id
  end

  def get_driver_id(driver_feed)
    Driver.find_by_ergast_driver_id(driver_feed['driverId']).id
  end

  def calculate_race_datetime(race_date, race_time)
    r_date = Date.parse(race_date)
    r_time = Time.parse(race_time)
    DateTime.new(r_date.year, r_date.month, r_date.day, r_time.hour, r_time.min, r_time.sec, 0)
  end

  # TODO: SDP: These functions are probably best documented for future reference. I find them
  # to be a little confusing
  def calculate_qly_datetime(race_datetime, circuit)
    case circuit['circuitId']
    when 'americas' || 'villeneuve'
      zone_a_offset(race_datetime)
    when 'albert_park' || 'shanghai' || 'marina_bay' || 'suzuka' || 'sochi'
      zone_b_offset(race_datetime)
    when 'sepang'
      zone_c_offset(race_datetime)
    else
      race_datetime - 24.hours
    end
  end

  def zone_a_offset(race_datetime)
    race_datetime - 25.hours
  end

  def zone_b_offset(race_datetime)
    race_datetime - 23.hours
  end

  def zone_c_offset(race_datetime)
    race_datetime - 22.hours
  end
end
