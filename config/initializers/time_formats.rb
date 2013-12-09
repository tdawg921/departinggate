# config/initializers/time_formats.rb
Date::DATE_FORMATS[:default] = '%m/%d/%Y'
Date::DATE_FORMATS[:db] = '%Y-%d-%m'
Date::DATE_FORMATS[:amadeus] = '%d%m%y'