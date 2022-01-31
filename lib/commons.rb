require 'date'

module Commons
  BASE_WORD = "whack".freeze
  BASE_DAY = Date.strptime('26-01-2022', '%d-%m-%Y').freeze
  MATCHING_REGEX = /s[earotl]{4}/
end
