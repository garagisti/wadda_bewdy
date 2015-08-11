FactoryGirl.define do
  factory :valid_round, class: Round do
    round_number 1  # First Round
    circuit_id 1    # Australia
    qly_datetime '2015-03-14 06:00:00.000000'
    race_datetime '2015-03-15 05:00:00.000000'
  end
end