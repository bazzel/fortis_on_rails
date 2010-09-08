# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :upload do |f|
  f.period_start "2010-09-08"
  f.period_end "2010-09-08"
  f.balance_start 1
  f.balance_end 1
end
