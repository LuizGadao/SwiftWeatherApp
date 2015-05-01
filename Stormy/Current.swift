//
//  Current.swift
//  Stormy
//
//  Created by Luiz Carlos Gonçalves dos Anjos on 01/05/15.
//  Copyright (c) 2015 Luiz Carlos Gonçalves dos Anjos. All rights reserved.
//

import Foundation
import UIKit

/*
{
apparentTemperature = "62.76";
cloudCover = "0.26";
dewPoint = "50.12";
humidity = "0.63";
icon = "partly-cloudy-day";
nearestStormBearing = 220;
nearestStormDistance = 5;
ozone = "365.96";
precipIntensity = 0;
precipProbability = 0;
pressure = "1012.38";
summary = "Partly Cloudy";
temperature = "62.76";
time = 1430517873;
visibility = "9.300000000000001";
windBearing = 258;
windSpeed = "12.06";
}
*/

struct Current{
    var currentTime:String = ""
    var temperature:Int
    var humidity:Double
    var preciptProbability:Double
    var summary:String
    var icon:UIImage?
    
    init(weatherDictionary:NSDictionary){
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
        temperature = currentWeather["temperature"] as! Int
        humidity = currentWeather["humidity"] as! Double
        preciptProbability = currentWeather["precipProbability"] as! Double
        summary = currentWeather["summary"] as! String
        
        let iconStr = currentWeather["icon"] as! String
        icon = weatherIconFromString(iconStr)
        
        let currentTimeIntValue = currentWeather["time"] as! Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
        
    }
    
    func dateStringFromUnixTime(unixTime:Int)->String{
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(strIcon:String)-> UIImage {
        
        var imageName:String
        
        switch strIcon{
            case "clear-day":
                imageName = "clear-day"
            case "clear-night":
                imageName = "clear-night"
            case "rain":
                imageName = "rain"
            case "snow":
                imageName = "snow"
            case "sleet":
                imageName = "sleet"
            case "wind":
                imageName = "wind"
            case "fog":
                imageName = "fog"
            case "cloudy":
                imageName = "cloudy"
            case "partly-cloudy-day":
                imageName = "partly-cloudy"
            case "partly-cloudy-night":
                imageName = "cloudy-night"
            default:
                imageName = "default"
        }
        
        return UIImage(named: imageName)!
    }
    
}

















