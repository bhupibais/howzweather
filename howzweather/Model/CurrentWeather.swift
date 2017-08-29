//
//  CurrentWeather.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-23.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
// We will keep all the variables tht will keep track of weather data.

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter ()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    /*var weatherType: String {
        
        if _weatherType == nil {
         _weatherType = ""
        }
        return _weatherType
    }*/
    var weatherType: String {
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails (completed: @escaping DownloadComplete){
         Alamofire.request(CURRENT_WEATHER_URL).responseJSON{response in
         let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let name = dict["name"] as? String {
                    
                  self._cityName = name.capitalized
                    
                }
                if let weather = dict["weather"] as? [Dictionary<String, Any>]  {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        
                    }
                }
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelsiusPreDivision = currentTemperature - 273.15
                        let kelvinToCelsius = Double (round(10 * kelvinToCelsiusPreDivision/10))
                        self._currentTemp = kelvinToCelsius
                     
                    }
                }
            }
            completed()
        }
        
    }
    
}
