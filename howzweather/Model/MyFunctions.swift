//
//  MyFunctions.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-09-02.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import Foundation

class MyFunctions {
    
  func ConvertToCelsiusFromKelvin(temp: Double) -> String {
        let kelvinToCelsiusPreDivision = temp - 273.15
        let kelvinToCelsius = Double (round(10 * kelvinToCelsiusPreDivision/10))
        return  "\(kelvinToCelsius)"
    }
    
   func getHoursMins(unixDate: Double)-> String
    {
        let unixConvertedDate = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        //let hourMins = dateFormatter.string(from : Date())
        let hourMins = dateFormatter.string(from : unixConvertedDate)
        //mktFormatter.timeZone = NSTimeZone(name: "US/Eastern")
        let result: String! = "\(hourMins)"
        return result
    }
    
    
}
