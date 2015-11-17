//
//  ViewController.swift
//  LocalWeather
//
//  Created by Андрей Букша on 17.11.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var weatherDescLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windDirectionLbl: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        weather = Weather(cityID: 540761)
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func updateUI() {
        weatherImg.image = UIImage(named: weather.icon)
        temperatureLbl.text = "\(weather.temperature)\u{00B0}C"
        weatherDescLbl.text = weather.weatherDesc.capitalizedString
        pressureLbl.text = "\(weather.pressure) mmHg"
        windSpeedLbl.text = "\(weather.windSpeed) m/s"
        windDirectionLbl.text = "\(weather.windDirection)"
        sunriseLbl.text = weather.sunrise
        sunsetLbl.text = weather.sunset
        cityLbl.text = weather.cityName.capitalizedString
    }
    


}

