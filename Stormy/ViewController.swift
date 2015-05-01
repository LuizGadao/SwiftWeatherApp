//
//  ViewController.swift
//  Stormy
//
//  Created by Luiz Carlos Gonçalves dos Anjos on 28/04/15.
//  Copyright (c) 2015 Luiz Carlos Gonçalves dos Anjos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let API_KEY = "5eba174091e0725e8b0ffa3e758de11d"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(API_KEY)/")
        let forecastURL = NSURL(string:"37.8267,-122.423", relativeToURL:baseURL)
        
        let shareSessinon = NSURLSession.sharedSession()
        let donwloadTask : NSURLSessionDownloadTask = shareSessinon.downloadTaskWithURL(forecastURL!,
            completionHandler: { (
                location:NSURL!,
                response:NSURLResponse!,
                error:NSError!) -> Void in
                //println(response)
                //var urlContents = NSString(contentsOfURL: location, encoding: NSUTF8StringEncoding, error: nil)
                //println(urlContents)
                
                if error == nil{
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary:NSDictionary = NSJSONSerialization.JSONObjectWithData(
                        dataObject!, options: nil, error: nil) as! NSDictionary
                    
                    
                    let currentWeather = Current(weatherDictionary: weatherDictionary)
                    println(currentWeather.currentTime)
                }
                
        })
        donwloadTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

