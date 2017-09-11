//
//  ViewController.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import YelpAPI

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var draggableBackground: DraggableViewBackground?
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        print(locationManager.location?.coordinate.latitude ?? 66.66)
        
        draggableBackground = DraggableViewBackground(frame: self.view.frame)
        draggableBackground?.location = locationManager
        self.view.addSubview(draggableBackground!)
        draggableBackground?.parentController = self
        self.draggableBackground?.settingsButton.addTarget(self, action: #selector(self.settingsClicked), for: UIControlEvents.touchUpInside)

        // TODO: Replace this query with somthing dynamic
        let query = YLPQuery(location: "San Francisco, CA")
        query.term = "lunch"
        query.limit = 10
        
        YLPClient.sharedInstance.flatMap { client in
            client.search(withQuery: query)
        }.onSuccess { search in
            self.draggableBackground?.appendCards(cards: search.businesses)
        }.onFailure { error in
            print("Search errored: \(error)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingsClicked() -> Void {
        print("Button Clicked.....")
        //SettingsViewController
        
        let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsView
        self.present(loginPageView, animated: true, completion: nil)
    }


}

