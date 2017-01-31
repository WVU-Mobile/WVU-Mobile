//
//  DiningInfoViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit
import GoogleMaps

class DiningInfoViewController: UIViewController {
    var diningHall = DiningHall.Arnold
    
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var map: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.info.text = diningHall.description
        self.hours.text = diningHall.hoursOfOperation
        
        let camera = GMSCameraPosition.camera(withLatitude: diningHall.latitude, longitude: diningHall.longitude, zoom: 14)
        self.map.camera = camera
        
        let position = CLLocationCoordinate2D(latitude: diningHall.latitude, longitude: diningHall.longitude)
        let marker = GMSMarker(position: position)
        marker.map = map
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
