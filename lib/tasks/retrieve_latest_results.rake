desc "Updating Round Results"
task :retrieve_latest_results => :environment do
  puts "Reminding users of registration"
  ResultWorker.new.perform(round_id)
  puts "done."
end