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
    private var _countryName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    private var _sunRise: String!
    private var _sunSet: String!
    private var _wind: String!
    private var _humidity: String!
    private var _pressure: String!
    private var _visibility: String!
    
    private var _tempMin: Double!
    private var _tempMax: Double!
    
    var   myfunctionsObj: MyFunctions!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var countryName: String {
        if _countryName == nil {
           _countryName = ""
        }
        return _countryName
    }
    
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter ()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today,\(currentDate)"
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
    
    var sunRise : String {
        if _sunRise == nil {
            _sunRise = ""
        }
        return _sunRise
    }
    var sunSet: String{
        if _sunSet == nil {
            _sunSet = ""
        }
        return _sunSet
    }
    var wind: String {
        if _wind == nil {
          _wind = ""
            
        }
        return _wind
    }
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    var pressure: String {
        if _pressure == nil {
            
            _pressure = ""
        }
        return _pressure
    }
    
    var visibility: String {
        if _visibility == nil {
          _visibility = ""
        }
        return _visibility
    }
    
    var tempMin: Double {
        if _tempMin == nil {
            _tempMin = 0.0
        }
        return _tempMin
    }
    
    var tempMax: Double {
        if _tempMax == nil {
         _tempMax = 0.0
        }
        return _tempMax
    }
    
  
    
    
    func downloadWeatherDetails (completed: @escaping DownloadComplete){
        
        myfunctionsObj = MyFunctions ()
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{response in
         let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let name = dict["name"] as? String {
                  self._cityName = name.capitalized
                }
                
                if let sys = dict["sys"] as? Dictionary<String, Any> {
                    if let country = sys["country"] as? String {
                        self._countryName = country.uppercased()
                    }
                    
                    if let sunRise = sys["sunrise"] as? Double  {
                        self._sunRise = self.myfunctionsObj.getHoursMins(unixDate: sunRise)
                    }
                    if let sunSet = sys["sunset"] as? Double  {
                        self._sunSet = self.myfunctionsObj.getHoursMins(unixDate: sunSet)
                    }
                    
                }
                if let wind = dict["wind"] as? Dictionary<String, Any> {
                    if let speed = wind["speed"] as? Double {
                         self._wind = "\(3.6 * speed)"
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>]  {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        
                    }
                }
                if let visibility = dict["visibility"] as? Double {
                    self._visibility = "\(Int(visibility / 1000))"
                    
                }
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let currentTemperature = main["temp"] as? Double {
                       // let kelvinToCelsiusPreDivision = currentTemperature - 273.15
                        //let kelvinToCelsius = Double (round(10 * kelvinToCelsiusPreDivision/10))
                        //self._currentTemp = kelvinToCelsius
                        self._currentTemp = Double((self.myfunctionsObj?.ConvertToCelsiusFromKelvin(temp: currentTemperature))!)
                        
                    }
                    if let humidity = main["humidity"] as? Int {
                         self._humidity = "\(humidity)"
                    }
                    if let pressure = main["pressure"] as? Int {
                        self._pressure = "\((Double(pressure) * 0.1))"
                    }
                    if let minTemp = main["temp_min"] as? Double {
                        self._tempMin = Double((self.myfunctionsObj?.ConvertToCelsiusFromKelvin(temp: minTemp))!)
                    }
                    if let maxTemp = main["temp_max"] as? Double {
                        self._tempMax = Double((self.myfunctionsObj?.ConvertToCelsiusFromKelvin(temp: maxTemp))!)
                    }
                    
                }
                
            }
            completed()
        }
        
    }
    
}
