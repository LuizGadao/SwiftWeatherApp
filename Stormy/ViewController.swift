//
//  ViewController.swift
//  Stormy
//
//  Created by Luiz Carlos Gonçalves dos Anjos on 28/04/15.
//  Copyright (c) 2015 Luiz Carlos Gonçalves dos Anjos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    
    private let API_KEY = "5eba174091e0725e8b0ffa3e758de11d"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refresh()
    }
    
    func getCurrentWeatherData(){
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
                    //println(weatherDictionary)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.temperatureLabel.text = "\(currentWeather.temperature)"
                        self.iconWeather.image = currentWeather.icon!
                        self.timeLabel.text = currentWeather.currentTime
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.rainLabel.text = "\(currentWeather.preciptProbability)"
                        
                        self.showRefresh(hidden: true)
                    })
                }
                else{
                    let networkIssue = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error!", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
                    
                    networkIssue.addAction(okButton)
                    networkIssue.addAction(cancelButton)
                    
                    self.presentViewController(networkIssue, animated: true, completion: nil)
                    self.showRefresh(hidden: true)
                }
                
        })
        donwloadTask.resume()
    }
    
    func showRefresh(#hidden:Bool){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //stop refresh
            if hidden{
                self.refreshActivityIndicator.hidden = true
                self.refreshActivityIndicator.stopAnimating()
                self.refreshButton.hidden = false
            }
            else {//show activity indicator and hide button refresh
                self.refreshActivityIndicator.hidden = false
                self.refreshActivityIndicator.startAnimating()
                self.refreshButton.hidden = true
            }
        })
    }

    @IBAction func refresh() {
        showRefresh(hidden: false)
        //get data API
        getCurrentWeatherData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

