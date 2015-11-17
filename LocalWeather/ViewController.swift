//
//  ViewController.swift
//  LocalWeather
//
//  Created by Андрей Букша on 17.11.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let weat = Weather(cityID: 540761)
        weat.downloadWeatherDetails { () -> () in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

