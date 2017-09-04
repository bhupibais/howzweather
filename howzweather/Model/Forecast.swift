//
//  Forecast.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-24.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    //var forecasts = [Forecast]()
    
    var date: String {
        if _date == nil {
            _date = ""
         }
        return _date
    }
    var weatherType: String{
        if _weatherType == nil {
            _weatherType =  ""
        }
        return _weatherType
    }
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
            
        }
        return _highTemp
    }
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
   init ()
    {
    }
    
    init (weatherDict: Dictionary<String, Any>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            
            if let min = temp["min"] as? Double {
                    self._lowTemp = ConvertToCelsiusFromKelvin(temp: min)
                }
            if let max = temp["max"] as? Double {
                self._highTemp = ConvertToCelsiusFromKelvin(temp: max)
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>]{
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
            
        }
     }
    
    //no need to convert the temp from kelvin to celsius or fathanhiet as API itself does it
    //pass units=metric or imperial
    
    private func ConvertToCelsiusFromKelvin(temp: Double) -> String {
        let kelvinToCelsiusPreDivision = temp - 273.15
        let kelvinToCelsius = Double (round(10 * kelvinToCelsiusPreDivision/10))
        return  "\(kelvinToCelsius)"
        
    }
    
   /*func downlaodForecastDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for obj in list {
                        let forecast  = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        //print (obj)
                    }
                    self.tableView.reloadData()
                   self.forecasts.remove(at: 0)
                }
                
            }
           completed()
        }
       
    }*/
    
}


extension Date {
    func  dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
