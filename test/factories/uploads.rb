# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :upload do |f|
  f.csv File.new(Rails.root + 'test/fixtures/csv/861887719EURMutaties20100807-20100904.CSV')
end