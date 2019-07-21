class ResultWorker
  include Sidekiq::Worker

  ERGAST_API_F1 = 'http://ergast.com/api/f1/'
  SEASON = '2015'
  def perform()

    # Find the round ids that have been completed complete.
    rounds = Rounds.all
    rd_results = RoundResults.all

    finished_races = Array.new
    finished_qly = Array.new
    rounds.each do |round|
      if (round.race_datetime + 5.hours) < DateTime.now
        finished_races << round.id
      end
      if (round.qly_datetime + 5.hours) < DateTime.now
        finished_qly << round.id
      end
    end

    # confirm for each finished round id, that it is included in the race results table
    get_results(finished_races, rd_results, 'results')
    get_results(finished_qly, rd_results, 'qualifying')

    end
  end

  private

  def get_results(ids_to_retrieve, results, type)
    ids_to_retrieve.each do |round_id|
      if results.find_by_round_id(round_id).nil?
        # Make an API Call for #{round_id}
        puts "Making API call to Ergast F1 to get result for Round: #{round_id}"
        rest_data = RestClient.get("#{ERGAST_API_F1}#{SEASON}/#{round_id}/#{type}.json?limit=50")
        json_data = JSON.parse(rest_data)
        puts 'Processing'
        raceTable = json_data['MRData']['RaceTable']

        if !raceTable['Races'].nil?  do
          if type == 'qualifying'
            process_qly_results(json_data['MRData'])
          elsif type == 'results'
            process_round_results(json_data['MRData'])
          # Populate the round results DB with this detail.
          end
        end
      end
  end

  def process_qly_results(feed)


  end


  def process_round_results(feed)
    puts feed
  end
end
