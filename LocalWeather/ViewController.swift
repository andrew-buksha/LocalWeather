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
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var dayOneImg: UIImageView!
    @IBOutlet weak var dayOneDayTempLbl: UILabel!
    @IBOutlet weak var dayOneNightTempLbl: UILabel!
    @IBOutlet weak var dayOneDescLbl: UILabel!
    @IBOutlet weak var dayTwo: UILabel!
    @IBOutlet weak var dayTwoImg: UIImageView!
    @IBOutlet weak var dayTwoDayTempLbl: UILabel!
    @IBOutlet weak var dayTwoDayNightLbl: UILabel!
    @IBOutlet weak var dayTwoDescLbl: UILabel!
    @IBOutlet weak var dayThree: UILabel!
    @IBOutlet weak var dayThreeImg: UIImageView!
    @IBOutlet weak var dayThreeDayTempLbl: UILabel!
    @IBOutlet weak var dayThreeNightTempLbl: UILabel!
    @IBOutlet weak var dayThreeDescLbl: UILabel!
    @IBOutlet weak var todayIs: UILabel!
    
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
        humidityLbl.text = "\(weather.humidity) %"
        dayOneImg.image = UIImage(named: weather.dayOneIcon)
        dayOneDayTempLbl.text = "\(weather.dayOneDayTemp)\u{00B0}C"
        dayOneNightTempLbl.text = "\(weather.dayOneNightTemp)\u{00B0}C"
        dayOneDescLbl.text = weather.dayOneDesc
        dayTwo.text = weather.dayTwoName
        dayTwoImg.image = UIImage(named: weather.dayTwoIcon)
        dayTwoDayTempLbl.text = "\(weather.dayTwoDayTemp)\u{00B0}C"
        dayTwoDayNightLbl.text = "\(weather.dayThreeNightTemp)\u{00B0}C"
        dayTwoDescLbl.text = weather.dayTwoDesc
        dayThree.text = weather.dayThreeName
        dayThreeImg.image = UIImage(named: weather.dayThreeIcon)
        dayThreeDayTempLbl.text = "\(weather.dayThreeDayTemp)\u{00B0}C"
        dayThreeNightTempLbl.text = "\(weather.dayThreeNightTemp)\u{00B0}C"
        dayThreeDescLbl.text = weather.dayThreeDesc
        todayIs.text = weather.today
    }
    


}

