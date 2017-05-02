module Timezone exposing (timezones, Timezone)


type alias Timezone =
    { utc : String
    , offset : Float
    , text : String
    }


timezones : List Timezone
timezones =
    [ { offset = -12
      , text = "International Date Line West"
      , utc = "(UTC-12:00)"
      }
    , { offset = -11
      , text = "Coordinated Universal Time-11"
      , utc = "(UTC-11:00)"
      }
    , { offset = -10
      , text = "Hawaii"
      , utc = "(UTC-10:00)"
      }
    , { offset = -8
      , text = "Alaska"
      , utc = "(UTC-09:00)"
      }
    , { offset = -7
      , text = "Pacific Time (US & Canada)"
      , utc = "(UTC-08:00)"
      }
    , { offset = -6
      , text = "Central America"
      , utc = "(UTC-06:00)"
      }
    , { offset = -5
      , text = "Central Time (US & Canada)"
      , utc = "(UTC-06:00)"
      }
    , { offset = -4
      , text = "Eastern Time (US & Canada)"
      , utc = "(UTC-05:00)"
      }
    , { offset = -3
      , text = "Atlantic Time (Canada)"
      , utc = "(UTC-04:00)"
      }
    , { offset = -2.5
      , text = "Newfoundland"
      , utc = "(UTC-03:30)"
      }
    , { offset = -2
      , text = "Greenland"
      , utc = "(UTC-03:00)"
      }
    , { offset = -1
      , text = "Mid-Atlantic - Old"
      , utc = "(UTC-02:00)"
      }
    , { offset = 0
      , text = "Coordinated Universal Time"
      , utc = "(UTC)"
      }
    , { offset = 1
      , text = "Dublin, Edinburgh, Lisbon, London"
      , utc = "(UTC)"
      }
    , { offset = 2
      , text = "Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
      , utc = "(UTC+01:00)"
      }
    , { offset = 3
      , text = "Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius"
      , utc = "(UTC+02:00)"
      }
    , { offset = 4
      , text = "Moscow, St. Petersburg, Volgograd"
      , utc = "(UTC+04:00)"
      }
    , { offset = 4.5
      , text = "Kabul"
      , utc = "(UTC+04:30)"
      }
    , { offset = 5
      , text = "Ashgabat, Tashkent"
      , utc = "(UTC+05:00)"
      }
    , { offset = 5.5
      , text = "Chennai, Kolkata, Mumbai, New Delhi"
      , utc = "(UTC+05:30)"
      }
    , { offset = 5.75
      , text = "Kathmandu"
      , utc = "(UTC+05:45)"
      }
    , { offset = 6
      , text = "Astana"
      , utc = "(UTC+06:00)"
      }
    , { offset = 6.5
      , text = "Yangon (Rangoon)"
      , utc = "(UTC+06:30)"
      }
    , { offset = 7
      , text = "Bangkok, Hanoi, Jakarta"
      , utc = "(UTC+07:00)"
      }
    , { offset = 8
      , text = "Kuala Lumpur, Singapore"
      , utc = "(UTC+08:00)"
      }
    , { offset = 9
      , text = "Osaka, Sapporo, Tokyo"
      , utc = "(UTC+09:00)"
      }
    , { offset = 9.5
      , text = "Adelaide"
      , utc = "(UTC+09:30)"
      }
    , { offset = 10
      , text = "Canberra, Melbourne, Sydney"
      , utc = "(UTC+10:00)"
      }
    , { offset = 11
      , text = "Vladivostok"
      , utc = "(UTC+11:00)"
      }
    , { offset = 12
      , text = "Auckland, Wellington"
      , utc = "(UTC+12:00)"
      }
    , { offset = 12
      , text = "Fiji"
      , utc = "(UTC+12:00)"
      }
    , { offset = 13
      , text = "Nuku'alofa"
      , utc = "(UTC+13:00)"
      }
    ]
