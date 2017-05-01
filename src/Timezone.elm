module Timezone exposing (timezones, Timezone)


type alias Timezone =
    { value : String
    , abbr : String
    , offset : Float
    , text : String
    }


timezones : List Timezone
timezones =
    [ { value = "Dateline Standard Time"
      , abbr = "DST"
      , offset = -12
      , text = "(UTC-12:00) International Date Line West"
      }
    , { value = "UTC-11"
      , abbr = "U"
      , offset = -11
      , text = "(UTC-11:00) Coordinated Universal Time-11"
      }
    , { value = "Hawaiian Standard Time"
      , abbr = "HST"
      , offset = -10
      , text = "(UTC-10:00) Hawaii"
      }
    , { value = "Alaskan Standard Time"
      , abbr = "AKDT"
      , offset = -8
      , text = "(UTC-09:00) Alaska"
      }
    , { value = "Pacific Standard Time"
      , abbr = "PDT"
      , offset = -7
      , text = "(UTC-08:00) Pacific Time (US & Canada)"
      }
    , { value = "Central America Standard Time"
      , abbr = "CAST"
      , offset = -6
      , text = "(UTC-06:00) Central America"
      }
    , { value = "Central Standard Time"
      , abbr = "CDT"
      , offset = -5
      , text = "(UTC-06:00) Central Time (US & Canada)"
      }
    , { value = "Eastern Standard Time"
      , abbr = "EDT"
      , offset = -4
      , text = "(UTC-05:00) Eastern Time (US & Canada)"
      }
    , { value = "Atlantic Standard Time"
      , abbr = "ADT"
      , offset = -3
      , text = "(UTC-04:00) Atlantic Time (Canada)"
      }
    , { value = "Newfoundland Standard Time"
      , abbr = "NDT"
      , offset = -2.5
      , text = "(UTC-03:30) Newfoundland"
      }
    , { value = "Greenland Standard Time"
      , abbr = "GDT"
      , offset = -2
      , text = "(UTC-03:00) Greenland"
      }
    , { value = "Mid-Atlantic Standard Time"
      , abbr = "MDT"
      , offset = -1
      , text = "(UTC-02:00) Mid-Atlantic - Old"
      }
    , { value = "UTC"
      , abbr = "CUT"
      , offset = 0
      , text = "(UTC) Coordinated Universal Time"
      }
    , { value = "GMT Standard Time"
      , abbr = "GDT"
      , offset = 1
      , text = "(UTC) Dublin, Edinburgh, Lisbon, London"
      }
    , { value = "W. Europe Standard Time"
      , abbr = "WEDT"
      , offset = 2
      , text = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
      }
    , { value = "FLE Standard Time"
      , abbr = "FDT"
      , offset = 3
      , text = "(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius"
      }
    , { value = "Russian Standard Time"
      , abbr = "RST"
      , offset = 4
      , text = "(UTC+04:00) Moscow, St. Petersburg, Volgograd"
      }
    , { value = "Afghanistan Standard Time"
      , abbr = "AST"
      , offset = 4.5
      , text = "(UTC+04:30) Kabul"
      }
    , { value = "West Asia Standard Time"
      , abbr = "WAST"
      , offset = 5
      , text = "(UTC+05:00) Ashgabat, Tashkent"
      }
    , { value = "India Standard Time"
      , abbr = "IST"
      , offset = 5.5
      , text = "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi"
      }
    , { value = "Nepal Standard Time"
      , abbr = "NST"
      , offset = 5.75
      , text = "(UTC+05:45) Kathmandu"
      }
    , { value = "Central Asia Standard Time"
      , abbr = "CAST"
      , offset = 6
      , text = "(UTC+06:00) Astana"
      }
    , { value = "Myanmar Standard Time"
      , abbr = "MST"
      , offset = 6.5
      , text = "(UTC+06:30) Yangon (Rangoon)"
      }
    , { value = "SE Asia Standard Time"
      , abbr = "SAST"
      , offset = 7
      , text = "(UTC+07:00) Bangkok, Hanoi, Jakarta"
      }
    , { value = "Singapore Standard Time"
      , abbr = "MPST"
      , offset = 8
      , text = "(UTC+08:00) Kuala Lumpur, Singapore"
      }
    , { value = "Tokyo Standard Time"
      , abbr = "TST"
      , offset = 9
      , text = "(UTC+09:00) Osaka, Sapporo, Tokyo"
      }
    , { value = "Cen. Australia Standard Time"
      , abbr = "CAST"
      , offset = 9.5
      , text = "(UTC+09:30) Adelaide"
      }
    , { value = "AUS Eastern Standard Time"
      , abbr = "AEST"
      , offset = 10
      , text = "(UTC+10:00) Canberra, Melbourne, Sydney"
      }
    , { value = "Vladivostok Standard Time"
      , abbr = "VST"
      , offset = 11
      , text = "(UTC+11:00) Vladivostok"
      }
    , { value = "New Zealand Standard Time"
      , abbr = "NZST"
      , offset = 12
      , text = "(UTC+12:00) Auckland, Wellington"
      }
    , { value = "Fiji Standard Time"
      , abbr = "FST"
      , offset = 12
      , text = "(UTC+12:00) Fiji"
      }
    , { value = "Tonga Standard Time"
      , abbr = "TST"
      , offset = 13
      , text = "(UTC+13:00) Nuku'alofa"
      }
    ]
