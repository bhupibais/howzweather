//
//  Location.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-28.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import CoreLocation

class Location {
   static  var sharedInstance = Location()
    private init() {}
    
     var latitude: Double!
     var longitude: Double!
    
    func getCurrentHour()-> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentHour = dateFormatter.string(from : Date())
        //mktFormatter.timeZone = NSTimeZone(name: "US/Eastern")
        let result: Int! = Int(currentHour)!
        
        return result
    }
    
}
