//
//  Constants.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-23.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import Foundation

let BASE_URL  = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE  = "lat="
let LONGITUDE = "&lon="
let APP_ID    = "&appid="
let API_KEY   = "c419a9ece46eeeab78bf8661a3110e30"

typealias DownloadComplete = () -> ()

//let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)43.88\(LONGITUDE)-78.93\(APP_ID)\(API_KEY)"

//let FORECAST_WEATHER_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=43.88&lon=-78.93&cnt=16&appid=c419a9ece46eeeab78bf8661a3110e30"


let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=16&appid=c419a9ece46eeeab78bf8661a3110e30"
