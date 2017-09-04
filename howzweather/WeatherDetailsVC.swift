//
//  WeatherDetailsVCMain.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-31.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import UIKit

protocol ReturningFromWeatherDetails {
    
    func setReturningFromWDVC(sendValue: Bool)
}

class WeatherDetailsVC: UIViewController {
    
    @IBOutlet weak var weatherDetailCityNameLabel: UILabel!
    @IBOutlet weak var weatherDetailDayOfTheWeekDateLabel: UILabel!
    @IBOutlet weak var weatherDetailsImage: UIImageView!
    @IBOutlet weak var weatherDetailWeatherTypeLabel: UILabel!
    @IBOutlet weak var weatherDetailTempLabel: UILabel!
    @IBOutlet weak var weatherDetailSunRiseLabel: UILabel!
    @IBOutlet weak var weatherDetailSunSetLabel: UILabel!
    @IBOutlet weak var weatherDetailWindLabel: UILabel!
    @IBOutlet weak var weatherDetailHumidityLabel: UILabel!
    @IBOutlet weak var weatherDetailPressureLabel: UILabel!
    @IBOutlet weak var weatherDetailVisibilityLabel: UILabel!
    @IBOutlet weak var weatherDetailMinTempLabel: UILabel!
    @IBOutlet weak var weatherDetailMaxTempLabel: UILabel!
    
    
    var myProtocol: ReturningFromWeatherDetails? = nil
    
    var backbtnpressed: Bool!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if myProtocol != nil {
            backbtnpressed = true
            //self.myProtocol?.setReturningFromWDVC(sendValue: backbtnpressed)
            myProtocol?.setReturningFromWDVC(sendValue: backbtnpressed)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    var currentWeatherInWeatherDetials: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           //currentWeatherInWeatherDetials = CurrentWeather()
           // currentWeatherInWeatherDetials = 
        currentWeatherInWeatherDetials.downloadWeatherDetails {
            
          self.updateWeatherDetailsMainUI()
            
        }
        
        
    }
    
    func updateWeatherDetailsMainUI(){
        weatherDetailCityNameLabel.text = currentWeatherInWeatherDetials.cityName + ", " + currentWeatherInWeatherDetials.countryName
        weatherDetailDayOfTheWeekDateLabel.text = currentWeatherInWeatherDetials.date
        weatherDetailWeatherTypeLabel.text = currentWeatherInWeatherDetials.weatherType
        let currentHour = Location.sharedInstance.getCurrentHour()
        
        if currentWeatherInWeatherDetials.weatherType == "Clear" {
            if ( currentHour >= 18 || currentHour <= 7 ) {
                currentWeatherInWeatherDetials.weatherType = "Clearnight"
            }
        }
        
        weatherDetailsImage.image = UIImage(named: currentWeatherInWeatherDetials.weatherType)
        weatherDetailTempLabel.text = "\(currentWeatherInWeatherDetials.currentTemp)°"
        
        weatherDetailSunRiseLabel.text = "Sun Rise " + currentWeatherInWeatherDetials.sunRise
        weatherDetailSunSetLabel.text =  "Sun Set  " + currentWeatherInWeatherDetials.sunSet
        weatherDetailMinTempLabel.text = "Min Temp " + "\(currentWeatherInWeatherDetials.tempMin)°"
        weatherDetailMaxTempLabel.text = "Max Temp " + "\(currentWeatherInWeatherDetials.tempMax)°"
        
        weatherDetailWindLabel.text = "Wind " + currentWeatherInWeatherDetials.wind + " km/h"
        weatherDetailHumidityLabel.text = "Humidity " + currentWeatherInWeatherDetials.humidity + " %"
        weatherDetailPressureLabel.text = "Pressure " + currentWeatherInWeatherDetials.pressure + " kPa"
        weatherDetailVisibilityLabel.text = "Visibilty " + currentWeatherInWeatherDetials.visibility + " km"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}
