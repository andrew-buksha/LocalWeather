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
    private var _windDirection: String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _weatherUrl: String!
    
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
        if _icon == nil {
            _icon = ""
        }
        return _icon
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
    
    var windDirection: String {
        if _windDirection == nil {
            _windDirection = ""
        }
        return _windDirection
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
        
        _weatherUrl = "\(WEATHER_URL)&id=\(self._cityID)\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        self._cityID = 540761
        let url = NSURL(string: self._weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let weatherDesc = weather[0]["description"] as? String {
                        self._weatherDesc = weatherDesc
                    }
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                    }
                }
                if let main = dict["main"] as? Dictionary<String,AnyObject> {
                    if let temperature = main["temp"] as? Double {
                        self._temperature = "\(temperature)"
                    }
                    if let pressure = main["pressure"] as? Double {
                        self._pressure = "\(pressure)"
                    }
                    if let humidity = main["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                    }
                    
                }
                if let wind = dict["wind"] as? Dictionary<String,AnyObject> {
                    if let windSpeed = wind["speed"] as? Double {
                        self._windSpeed = "\(windSpeed)"
                    }
                }
                if let sys = dict["sys"] as? Dictionary<String,AnyObject> {
                    if let sunrise = sys["sunrise"] as? Int {
                        self._sunrise = "\(sunrise)"
                    }
                    if let sunset = sys["sunset"] as? Int {
                        self._sunset = "\(sunset)"
                    }
                }
                if let cityName = dict["name"] as? String {
                    self._cityName = cityName
                }
                
            }
            
            print("Weather: \(self._weatherDesc)")
            print("Icon name: \(self._icon)")
            print("Temperature: \(self._temperature)")
            print("Pressure: \(self._pressure)")
            print("Speed of wind: \(self._windSpeed)")
            print("Sunrise time: \(self._sunrise)")
            print("Sunset time: \(self._sunset)")
            print("City name is: \(self._cityName)")
        }
    }
    
}
