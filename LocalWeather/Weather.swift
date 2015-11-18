//
//  Weather.swift
//  LocalWeather
//
//  Created by Андрей Букша on 17.11.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    private var _cityName: String!
    private var _cityID: Int!
    private var _cityAltitude: String!
    private var _cityLongtitude: String!
    private var _today: String!
    private var _weatherDesc: String!
    private var _icon: String!
    private var _temperature: String!
    private var _pressure: String!
    private var _humidity: String!
    private var _windSpeed: String!
    private var _windDirection: WindDirections!
    private var _sunrise: String!
    private var _sunset: String!
    private var _weatherUrl: String!
    private var _dayOneIcon: String!
    private var _dayOneDayTemp: String!
    private var _dayOneNightTemp: String!
    private var _dayOneDesc: String!
    private var _dayTwoName: String!
    private var _dayTwoIcon: String!
    private var _dayTwoDayTemp: String!
    private var _dayTwoNightTemp: String!
    private var _dayTwoDesc: String!
    private var _dayThreeName: String!
    private var _dayThreeIcon: String!
    private var _dayThreeDayTemp: String!
    private var _dayThreeNightTemp: String!
    private var _dayThreeDesc: String!
    
    enum WindDirections: String {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SSW
        case SW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }
    
    var windDirection: WindDirections {
        get {
            return _windDirection
        }
    }
    
    var today: String {
        if _today == nil {
            _today = ""
        }
        return _today
    }

    
    var dayOneIcon: String {
        if _dayOneIcon == nil {
            _dayOneIcon = ""
        }
        return _dayOneIcon
    }
    
    var dayOneDayTemp: String {
        if _dayOneDayTemp == nil {
            _dayOneDayTemp = ""
        }
        return _dayOneDayTemp
    }
    
    var dayOneNightTemp: String {
        if _dayOneNightTemp == nil {
            _dayOneNightTemp = ""
        }
        return _dayOneNightTemp
    }
    
    var dayOneDesc: String {
        if _dayOneDesc == nil {
            _dayOneDesc = ""
        }
        return _dayOneDesc
    }
    
    var dayTwoName: String {
        if _dayTwoName == nil {
            _dayTwoName = ""
        }
        return _dayTwoName
    }
    
    var dayTwoIcon: String {
        if _dayTwoIcon == nil {
            _dayTwoIcon = ""
        }
        return _dayTwoIcon
    }
    
    var dayTwoDayTemp: String {
        if _dayTwoDayTemp == nil {
            _dayTwoDayTemp = ""
        }
        return _dayTwoDayTemp
    }
    
    var dayTwoNightTemp: String {
        if _dayTwoNightTemp == nil {
            _dayTwoNightTemp = ""
        }
        return _dayTwoNightTemp
    }
    
    var dayTwoDesc: String {
        if _dayTwoDesc == nil {
            _dayTwoDesc = ""
        }
        return _dayTwoDesc
    }
    
    var dayThreeName: String {
        if _dayThreeName == nil {
            _dayThreeName = ""
        }
        return _dayThreeName
    }
    
    var dayThreeIcon: String {
        if _dayThreeIcon == nil {
            _dayThreeIcon = ""
        }
        return _dayThreeIcon
    }
    
    var dayThreeDayTemp: String {
        if _dayThreeDayTemp == nil {
            _dayThreeDayTemp = ""
        }
        return _dayThreeDayTemp
    }
    
    var dayThreeNightTemp: String {
        if _dayThreeNightTemp == nil {
            _dayThreeNightTemp = ""
        }
        return _dayThreeNightTemp
    }
    
    var dayThreeDesc: String {
        if _dayThreeDesc == nil {
            _dayThreeDesc = ""
        }
        return _dayThreeDesc
    }
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var cityID: Int {
        return _cityID
    }
    
    var cityAltitude: String {
        if _cityAltitude == nil {
            _cityAltitude = ""
        }
        return _cityAltitude
    }
    
    var cityLongtitude: String {
        if _cityLongtitude == nil {
            _cityLongtitude = ""
        }
        return _cityLongtitude
    }
    
    var weatherDesc: String {
        if _weatherDesc == nil {
            _weatherDesc = ""
        }
        return _weatherDesc
    }
    
    var icon: String {
        get {
            if _icon == nil {
                _icon = ""
            }
            return _icon

        }
    }
    
    var temperature: String {
        if _temperature == nil {
            _temperature = ""
        }
        return _temperature
    }
    
    var  pressure: String {
        if _pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
    var sunrise: String {
        if _sunrise == nil {
            _sunrise = ""
        }
        return _sunrise
    }
    
    var sunset: String {
        if _sunset == nil {
            _sunset = ""
        }
        return _sunset
    }
    
    init(cityID: Int) {
        self._cityID = cityID
        
        _weatherUrl = "\(WEATHER_URL)id=\(self._cityID)\(UNITS)\(API_KEY)"
    }
    
    
    
    func getTime(date: NSTimeInterval) -> String {
        let date1 = NSDate(timeIntervalSince1970: date)
        let calendar = NSCalendar.currentCalendar()
        let hour = calendar.component(NSCalendarUnit.Hour, fromDate: date1)
        let minute = calendar.component(NSCalendarUnit.Minute, fromDate: date1)
        let time = "\(hour):\(minute)"
        return time
    }
    
    func formatDate(unixDate: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixDate)
        let weekDay = NSDateFormatter()
        weekDay.dateFormat = "EEEE"
        let formattedDate = weekDay.stringFromDate(date)
        return formattedDate
    }
    
    func convertPressure(press: Double) -> Double {
        let converted = press * 0.75006375541921
        return converted
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: self._weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let weatherDesc = weather[0]["description"] as? String {
                        self._weatherDesc = weatherDesc
                    }
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                        print(self._icon)
                    }
                }
                if let today = dict["dt"] as? Double {
                    let date = NSDate(timeIntervalSince1970: today)
                    let weekDay = NSDateFormatter()
                    weekDay.dateFormat = "EEEE, MMMM d"
                    let formattedDate = weekDay.stringFromDate(date)
                    self._today = formattedDate
                }
                if let main = dict["main"] as? Dictionary<String,AnyObject> {
                    if let temperature = main["temp"] as? Double {
                        self._temperature = NSString(format: "%.0f", temperature) as String
                    }
                    if let pressure = main["pressure"] as? Double {
                        self._pressure = NSString(format: "%.0f", self.convertPressure(pressure)) as String
                    }
                    if let humidity = main["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                    }
                    
                }
                if let wind = dict["wind"] as? Dictionary<String,AnyObject> {
                    if let windSpeed = wind["speed"] as? Double {
                        self._windSpeed = "\(windSpeed)"
                    }
                    if let windDirection = wind["deg"] as? Double {
                        switch (windDirection) {
                        case 11.25..<33.75:
                            self._windDirection = WindDirections.NNE
                        case 33.75..<56.25:
                            self._windDirection = WindDirections.NE
                        case 56.25..<78.75:
                            self._windDirection = WindDirections.ENE
                        case 78.75..<101.25:
                            self._windDirection = WindDirections.E
                        case 101.25..<123.75:
                            self._windDirection = WindDirections.ESE
                        case 123.75..<146.25:
                            self._windDirection = WindDirections.SE
                        case 146.25..<168.75:
                            self._windDirection = WindDirections.SSE
                        case 168.75..<191.25:
                            self._windDirection = WindDirections.S
                        case 191.25..<213.75:
                            self._windDirection = WindDirections.SSW
                        case 213.75..<236.25:
                            self._windDirection = WindDirections.SW
                        case 236.25..<258.75:
                            self._windDirection = WindDirections.WSW
                        case 258.75..<281.25:
                            self._windDirection = WindDirections.W
                        case 282.25..<303.75:
                            self._windDirection = WindDirections.WNW
                        case 303.75..<326.25:
                            self._windDirection = WindDirections.NW
                        case 326.25..<348.75:
                            self._windDirection = WindDirections.NNW
                        default:
                            self._windDirection = WindDirections.N
                        }
                    }
                }
                if let sys = dict["sys"] as? Dictionary<String,AnyObject> {
                    if let sunrise = sys["sunrise"] as? NSTimeInterval {
                        
                        self._sunrise = self.getTime(sunrise)
                    }
                    if let sunset = sys["sunset"] as? NSTimeInterval {
                        self._sunset = self.getTime(sunset)
                    }
                }
                if let cityName = dict["name"] as? String {
                    self._cityName = cityName
                }
                
                
                let nsurl = NSURL(string: "\(FORECAST_URL)id=\(self._cityID)\(UNITS)\(API_KEY)")!
                Alamofire.request(.GET, nsurl).responseJSON(completionHandler: { (response) -> Void in
                    if let forecast = response.result.value as?  Dictionary<String,AnyObject> {
                        if let list = forecast["list"] as? [Dictionary<String,AnyObject>] {
                            if let dayOneTemp = list[1]["temp"] as? Dictionary<String,AnyObject> where dayOneTemp.count > 0{
                                if let dayOneDayTemp = dayOneTemp["day"] as? Double {
                                    self._dayOneDayTemp = NSString(format: "%.0f", dayOneDayTemp) as String
                                }
                                if let dayOneNightTemp = dayOneTemp["night"] as? Double {
                                    self._dayOneNightTemp = NSString(format: "%.0f", dayOneNightTemp) as String
                                }
                                
                            }
                            if let dayOneCond = list[1]["weather"] as? [Dictionary<String,AnyObject>] where dayOneCond.count > 0 {
                                if let dayOneIcon = dayOneCond[0]["icon"] as? String {
                                    self._dayOneIcon = dayOneIcon
                                }
                                if let dayOneDesc = dayOneCond[0]["description"] as? String {
                                    self._dayOneDesc = dayOneDesc
                                }
                            }
                            if let dayTwoName = list[2]["dt"] as? Double {
                                self._dayTwoName = self.formatDate(dayTwoName)
                            }
                            if let dayTwoTemp = list[2]["temp"] as? Dictionary<String,AnyObject> where dayTwoTemp.count > 0 {
                                if let dayTwoDayTemp = dayTwoTemp["day"] as? Double {
                                    self._dayTwoDayTemp = NSString(format: "%.0f", dayTwoDayTemp) as String
                                }
                                if let dayTwoNightTemp = dayTwoTemp["night"] as? Double {
                                    self._dayTwoNightTemp = NSString(format: "%.0f", dayTwoNightTemp) as String
                                }
                            }
                            if let dayTwoCond = list[2]["weather"] as? [Dictionary<String,AnyObject>] where dayTwoCond.count > 0 {
                                if let dayTwoIcon = dayTwoCond[0]["icon"] as? String {
                                    self._dayTwoIcon = dayTwoIcon
                                }
                                if let dayTwoDesc = dayTwoCond[0]["description"] as? String {
                                    self._dayTwoDesc = dayTwoDesc
                                }
                            }
                            if let dayThreeName = list[3]["dt"] as? Double {
                                self._dayThreeName = self.formatDate(dayThreeName)
                            }
                            if let dayThreeTemp = list[3]["temp"] as? Dictionary<String,AnyObject> where dayThreeTemp.count > 0 {
                                if let dayThreeDayTemp = dayThreeTemp["day"] as? Double {
                                    self._dayThreeDayTemp = NSString(format: "%.0f", dayThreeDayTemp) as String
                                }
                                if let dayThreeNightTemp = dayThreeTemp["night"] as? Double {
                                    self._dayThreeNightTemp = NSString(format: "%.0f", dayThreeNightTemp) as String
                                }
                            }
                            if let dayThreeCond = list[3]["weather"] as? [Dictionary<String,AnyObject>] where dayThreeCond.count > 0 {
                                if let dayThreeIcon = dayThreeCond[0]["icon"] as? String {
                                    self._dayThreeIcon = dayThreeIcon
                                }
                                if let dayThreeDesc = dayThreeCond[0]["description"] as? String {
                                    self._dayThreeDesc = dayThreeDesc
                                }
                            }
                            completed()

                        }
                    }


                })

            }

            
        }
    }
    
}
