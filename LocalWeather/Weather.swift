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
        
        _weatherUrl = "\(WEATHER_URL)&id=\(self._cityID)\(UNITS)\(API_KEY)"
    }
    
    
    
    func getTime(date: NSTimeInterval) -> String {
        let date1 = NSDate(timeIntervalSince1970: date)
        let calendar = NSCalendar.currentCalendar()
        let hour = calendar.component(NSCalendarUnit.Hour, fromDate: date1)
        let minute = calendar.component(NSCalendarUnit.Minute, fromDate: date1)
        let time = "\(hour):\(minute)"
        return time
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
                
                
            }
            
            completed()

            print("Weather: \(self._weatherDesc)")
            print("Icon name: \(self._icon)")
            print("Temperature: \(self._temperature)")
            print("Pressure: \(self._pressure)")
            print("Speed of wind: \(self._windSpeed)")
            print("Wind direction: \(self._windDirection)")
            print("Sunrise time: \(self._sunrise)")
            print("Sunset time: \(self._sunset)")
            print("City name is: \(self._cityName)")
        }
    }
    
}
