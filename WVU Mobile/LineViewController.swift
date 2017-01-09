//
//  LineViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser & Richard Deal on 3/31/15.
//  Copyright (c) 2015 WVUMobile. All rights reserved.
//

import UIKit
import GoogleMaps

class LineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate {
    
    var map = GMSMapView()
    var tableView = UITableView()
    
    var line: BusLine!
    var coords: Dictionary <String, CLLocationCoordinate2D>!
    var selected = -1
    var markerArray = [GMSMarker]()
    
    override func viewDidLoad() {
        self.title = line.name
        
        /*
        Set up Google Map View.
        */
        
        map = GMSMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 285))
        map.delegate = self

        let camera = GMSCameraPosition.camera(withLatitude: 39.635582, longitude: -79.954747, zoom: 12)
        map.animate(to: camera)
        
        self.view.addSubview(map)
        
        
        // Add each stop as Marker
        for stop in line.stops {
            let marker = GMSMarker()
            marker.position = coords[stop]!
            marker.title = stop
            marker.map = map
            marker.icon = GMSMarker.markerImage(with: Colors.homeYellow)
            markerArray.append(marker)
        }
        
        // Parse
        let path = Bundle.main.path(forResource: line.name, ofType: "txt")
        var text = ""
        
        do {
            text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            print("ugh")
        }
        
        let shape = GMSMutablePath()
        let shapeArray = text.components(separatedBy: "\n")
        for set in shapeArray {
            let c = set.components(separatedBy: "\t")
            shape.add(CLLocationCoordinate2DMake((c[0] as NSString).doubleValue, (c[1] as NSString).doubleValue))
        }
        let polyline = GMSPolyline(path: shape)
        polyline.strokeWidth = 5.0
        polyline.map = map
        
        self.view.addSubview(map)
        
        /*
        Set up Table View.
        */
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 285, width: self.view.frame.width, height: self.view.frame.height - 285), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        twitterButton()
        
        super.viewDidLoad()
    }
    
    func twitterButton() {
        let infoImage = UIImage(named: "twitterInfo")
        
        let infoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        infoView.image = infoImage
        infoView.image = infoView.image?.withRenderingMode(.alwaysTemplate)
        
        let infoButton = UIButton(frame: (infoView.bounds))
        infoButton.setBackgroundImage(infoView.image, for: .normal)
        infoButton.addTarget(self, action: #selector(LineViewController.loadTwitter), for: .touchUpInside)
        
        let infoButtonItem = UIBarButtonItem(customView: infoButton)
        
        self.navigationItem.rightBarButtonItem = infoButtonItem
    }
    
    func loadTwitter() {
        let feedPage = WebViewController()
        feedPage.url = "https://twitter.com/\(line.twitter)"
        self.navigationController?.pushViewController(feedPage, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return line.stops.count + 1
    }
    
    // Return number of sections in table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // Return header information for section.
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 25))
        let label = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, 25))
        label.textColor = colors.textColor
        headerView.backgroundColor = colors.secondaryColor
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.text = line.runTime
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        
        headerView.addSubview(label)
        
        return headerView
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = line.hoursString
        } else {
            cell.textLabel?.text = line.stops[indexPath.row - 1]
            cell.imageView?.image = UIImage(named: "Transportation")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            if selected != indexPath.row - 1 {
                selected = indexPath.row - 1
                let name = line.stops[selected]
                let camera = GMSCameraPosition(target: coords[name]!, zoom: 16, bearing: 0, viewingAngle: 0)
                map.animate(to: camera)
                map.selectedMarker = markerArray[indexPath.row - 1]
            }
            else {
                map.selectedMarker = nil
                let camera = GMSCameraPosition(target: CLLocationCoordinate2DMake(39.635582, -79.954747), zoom: 12, bearing: 0, viewingAngle: 0)
                map.animate(to: camera)
                tableView.cellForRow(at: indexPath)?.isSelected = false
                selected = -1
            }
        }
    }
}
