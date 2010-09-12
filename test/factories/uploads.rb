# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :upload do |f|
  # f.period_start "2010-09-08"
  # f.period_end "2010-09-08"
  # f.balance_start 1
  # f.balance_end 1
  f.csv File.new(Rails.root + 'test/fixtures/csv/861887719EURMutaties20100807-20100904.CSV')
end