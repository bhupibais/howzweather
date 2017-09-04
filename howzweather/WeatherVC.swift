//
//  WeatherVC.swift
//  howzweather
//
//  Created by BhupinderJit Bais on 2017-08-22.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate, ReturningFromWeatherDetails {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel! // will be used for City and Country
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather : CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    var returningFromWDVCValue: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    /*    tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.lightGray*/
        
        currentWeather = CurrentWeather ()
         //forecast = Forecast()
         self.returningFromWDVCValue = false
        print ("$$$$$$$$$$$$$$$\(self.returningFromWDVCValue)$$$$$$$$$$$$$$$")
    }
    
  override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
         currentLocation = locationManager.location
         Location.sharedInstance.latitude = currentLocation.coordinate.latitude
         Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                //setup UI to downlaod data
                self.downlaodForecastDetails {
                    //tableView.reloadData()
                    self.updateMainUI()
                }
            }
            
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast =  forecasts[indexPath.row]
             cell.configureCell(forecast: forecast)
             return cell
         }
        else{
            return WeatherCell()
        }
    }
    
    
    func setReturningFromWDVC(sendValue: Bool) {
        
        returningFromWDVCValue = sendValue
        
    }
    
    
    func updateMainUI(){
      dateLabel.text = currentWeather.date
      currentTempLabel.text = "\(currentWeather.currentTemp)°"
      currentWeatherTypeLabel.text = currentWeather.weatherType
      locationLabel.text = currentWeather.cityName + ", " + currentWeather.countryName
        
        let currentHour = Location.sharedInstance.getCurrentHour()
        
        if currentWeather.weatherType == "Clear" {
            if ( currentHour >= 18 || currentHour <= 7 ) {
                currentWeather.weatherType = "Clearnight"
            }
        }
 
      currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
    func downlaodForecastDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for obj in list {
                        let forecast  = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                       // print (obj)
                    }
                     //print ("<---------\(self.returningFromWDVCValue)-------->" )
                      //print ("************************\(!self.returningFromWDVCValue)*********************")
                     if self.returningFromWDVCValue != nil && self.returningFromWDVCValue == false   {
                        //print ("@@@@@Removing Current Day@@@@@@")
                        self.forecasts.remove(at: 0)
                        //print ("@@@@@ Over Current Day@@@@@@")
                        }
                    self.tableView.reloadData()
                }
                completed()
            }
            
        }
        
    }
    
    
    @IBAction func detialsButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "WeatherDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! WeatherDetailsVC
          destVC.myProtocol = self
          destVC.currentWeatherInWeatherDetials = currentWeather!
        
    }
    
    
    
} 

