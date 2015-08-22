class ResultWorker
  # include Sidekiq::Worker

  ERGAST_API_F1 = 'http://ergast.com/api/f1/'
  SEASON = '2015'

  byebug

  def perform()

    # Find the round ids that have been complete complete.
    rounds = Rounds.all
    finished_rounds = Array.new
      rounds.each do |round|
        if round.race_datetime < DateTime.now
          finished_rounds << round.id
        end
      end

    # confirm for each finished round id, that it is included in the race results table
    results = RoundResults.all
    finished_rounds.each do |round_id|
      if results.find_by_round_id(round_id).nil?
        # Make an API Call for #{round_id}
        puts 'Making API call to Ergast F1 to get Rounds Result'
        rest_data = RestClient.get("#{ERGAST_API_F1}#{season}/#{round_id}/results.json?limit=50")
        json_data = JSON.parse(rest_data)
        puts 'Processing'
        process_round_results(json_data['MRData'])
        # Populate the round results DB with this detail.
      end
    end
  end

  private

  def process_round_results(feed)
    puts feed
  end
end
