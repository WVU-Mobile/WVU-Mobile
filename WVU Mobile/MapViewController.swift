//
//  MapViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit
import GoogleMaps

extension MapViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            view.addSubview(tableView)
            filterContentForSearchText(searchText: searchController.searchBar.text!)
        } else {
            tableView.removeFromSuperview()
        }
    }
}

class MapViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var mapView = GMSMapView()
    
    var markers = [GMSMarker]()
    var filtered = [GMSMarker]()

    let locationManager = CLLocationManager()

    // filter objects 
    var tableView = UITableView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    struct MapCoordinate {
        var code: String
        var type: CoordinateType
        var name: String
        var latitude: Double
        var longitude: Double
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 39.635786, longitude: -79.954274, zoom: 14)
        
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        
        /*do {
            mapView.mapStyle = try GMSMapStyle(jsonString: MapStyles.dayMode)
        } catch {
            NSLog("The style definition could not be loaded: \(error)")
        }*/

        view = mapView
        
        parsePRTCoords()
        
        //search
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        navigationItem.titleView = searchController.searchBar
        
        tableView = UITableView(frame: mapView.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.alphaGray
    }
    
    func parsePRTCoords() {
        let path = Bundle.main.path(forResource: "PRT", ofType: "txt")

        do {
            let text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            
            let shape = GMSMutablePath()
            let shapeArray = text.components(separatedBy: "\n")
            for set in shapeArray {
                let c = set.components(separatedBy: "\t")
                shape.add(CLLocationCoordinate2DMake((c[0] as NSString).doubleValue, (c[1] as NSString).doubleValue))
            }
            let polyline = GMSPolyline(path: shape)
            polyline.strokeWidth = 5.0
            polyline.strokeColor = Colors.homeBlue
            polyline.map = mapView

        } catch {
            print("There was an error with MapViewController")
        }
        
        markers = setupMarkers(coords: coordinates)

    }
    
    func setupMarkers(coords: Array<MapCoordinate>) -> [GMSMarker]{
        var markers = [GMSMarker]()
        for coord in coords{
            let lat = coord.latitude
            let long = coord.longitude
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(long))
            marker.title = coord.code
            marker.snippet = coord.name
            marker.map = mapView
            marker.icon = GMSMarker.markerImage(with: coord.type.color)
            
            markers.append(marker)
        }
        
        return markers
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filtered = markers.filter { marker in
            return (marker.title?.lowercased().contains(searchText.lowercased()))! || (marker.snippet?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //let infoPage = MapInfoVC(name: marker.snippet, code: marker.title, latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        //self.navigationController?.pushViewController(infoPage, animated: true)
    }

    // Return number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtered.count
        }
        return markers.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c: GMSMarker
        
        if searchController.isActive && searchController.searchBar.text != "" {
            c = filtered[indexPath.row]
        } else {
            c = markers[indexPath.row]
        }
        
        let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: CLLocationDegrees(c.position.latitude), longitude: CLLocationDegrees(c.position.longitude)), zoom: 18, bearing: 30, viewingAngle: 90)
        mapView.animate(to: camera)
        mapView.selectedMarker = c
        
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = Colors.homeBlue
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        
        var c : GMSMarker
        
        if searchController.isActive && searchController.searchBar.text != "" {
            c = filtered[indexPath.row]
        } else {
            c = markers[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel?.text = c.title
        cell.detailTextLabel?.text = c.snippet
        
        return cell
    }
    
    func dismiss() {
        searchController.isActive = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var coordinates: Array <MapCoordinate> = [
        MapCoordinate(code: "WDB-D", type: .academic, name: "Woodburn Hall", latitude: 39.6359019354253, longitude: -79.9553555622697),
        MapCoordinate(code: "AEL-E", type: .academic, name: "Aerodynamics Laboratory", latitude: 39.645670, longitude: -79.974281),
        MapCoordinate(code: "AER-E", type: .academic, name: "Advanced Engineering Research Building", latitude: 39.646064, longitude: -79.971300),
        MapCoordinate(code: "AGS-E", type: .academic, name: "Agricultrial Sciences Building", latitude: 39.645768, longitude: -79.969936),
        MapCoordinate(code: "ALH-E",  type: .academic,  name: "Allen Hall", latitude: 39.646186, longitude: -79.967245),
        MapCoordinate(code: "ARM-D", type: .academic, name: "Armstrong Hall", latitude: 39.63505832, longitude: -79.95578438),
        MapCoordinate(code: "ASA-E", type: .academic, name: "Agricultural Sciences Annex", latitude: 39.646773, longitude: -79.968235),
        MapCoordinate(code: "BIC-E", type: .academic, name: "Bicentennial Housing", latitude: 39.639645, longitude: -79.935943),
        MapCoordinate(code: "BKH-D", type: .academic, name: "Brooks Hall", latitude: 39.635585, longitude: -79.956277),
        MapCoordinate(code: "BMRF-H", type: .academic, name: "Biomedical Research Facility", latitude: 39.655504, longitude: -79.957020),
        MapCoordinate(code: "BUE-D", type: .academic,  name: "Business and Economics Building", latitude: 39.636591, longitude: -79.954545),
        MapCoordinate(code: "CAC-E", type: .academic, name: "Creative Arts Center", latitude: 39.648136, longitude: -79.975703),
        MapCoordinate(code: "CHI-D", type: .academic, name: "Chitwood Hall", latitude: 39.636101, longitude: -79.954638),
        MapCoordinate(code: "CKH-D", type: .academic, name: "Clark Hall", latitude: 39.633747, longitude: -79.954364),
        MapCoordinate(code: "CLN-D", type: .academic, name: "Colson Hall", latitude: 39.633961, longitude: -79.955330),
        MapCoordinate(code: "COL-E", type: .academic, name: "Coliseum", latitude: 39.649228, longitude: -79.981588),
        MapCoordinate(code: "CS1-E", type: .academic, name: "Crime Scene House 1", latitude: 39.648919, longitude: -79.964796),
        MapCoordinate(code: "CS2-E", type: .academic, name: "Crime Scene House 2", latitude: 39.649303, longitude: -79.964376),
        MapCoordinate(code: "CS3-E", type: .academic, name: "Crime Scene House 3", latitude: 39.649330, longitude: -79.964668),
        MapCoordinate(code: "CSG-E", type: .academic, name: "Crime Scene Garage", latitude: 39.649070, longitude: -79.964985),
        MapCoordinate(code: "CRL-D", type: .academic, name: "Chemistry Research Laboratory", latitude: 39.633366, longitude: -79.953559),
        MapCoordinate(code: "CRP-E", type: .academic, name: "Chestnut Ridge Prof Building", latitude: 39.657176, longitude: -79.954237),
        MapCoordinate(code: "CRR-E", type: .academic, name: "Chestnut Ridge Research Building", latitude: 39.657046, longitude: -79.955224),
        MapCoordinate(code: "EIE-D", type: .academic, name: "Eisland Hall", latitude: 39.633687, longitude: -79.956106),
        MapCoordinate(code: "EMH-D", type: .academic, name: "Elizabeth Moore Hall", latitude: 39.634949, longitude: -79.955152),
        MapCoordinate(code: "ERA-E", type: .academic, name: "ERC RFL Annex Building", latitude: 39.648041, longitude: -79.965808),
        MapCoordinate(code: "ERB-E", type: .academic, name: "Engineering Research Building", latitude: 39.645674, longitude: -79.972463),
        MapCoordinate(code: "ESB-E", type: .academic, name: "Engineering Sciences Building", latitude: 39.64588716, longitude: -79.97374445),
        MapCoordinate(code: "EVL-E", type: .academic, name: "Evansdale Library", latitude: 39.645244, longitude: -79.971272),
        MapCoordinate(code: "FCH-E", type: .academic, name: "Fieldcrest Hall", latitude: 39.652458, longitude: -79.963139),
        MapCoordinate(code: "FH1-D", type: .academic, name: "650 Spruce", latitude: 39.633102, longitude: -79.951462),
        MapCoordinate(code: "FH2-D", type: .academic, name: "660 North High", latitude: 39.634039, longitude: -79.952016),
        MapCoordinate(code: "FH3-D", type: .academic, name: "670 North High", latitude: 39.634159, longitude: -79.951871),
        MapCoordinate(code: "FH4-D", type: .academic, name: "672 North High", latitude: 39.634380, longitude: -79.951776),
        MapCoordinate(code: "FH5-D", type: .academic, name: "216 Belmar", latitude: 39.635233, longitude: -79.950493),
        MapCoordinate(code: "FH6-D", type: .academic, name: "225 Belmar", latitude: 39.635455, longitude: -79.950040),
        MapCoordinate(code: "GRH-E", type: .academic, name: "Green House 1", latitude: 39.644174, longitude: -79.969498),
        MapCoordinate(code: "GSK-D", type: .academic, name: "Gaskins House", latitude: 39.635477, longitude: -79.951699),
        MapCoordinate(code: "HOD-D", type: .academic, name: "Hodges Hall", latitude: 39.634179, longitude: -79.956053),
        MapCoordinate(code: "HSN-H", type: .academic, name: "Health Science North", latitude: 39.655325, longitude: -79.958258),
        MapCoordinate(code: "HSS-H", type: .academic, name: "Health Science South", latitude: 39.654202, longitude: -79.957886),
        MapCoordinate(code: "KNP-D", type: .academic, name: "Knapp Hall", latitude: 39.632628, longitude: -79.956980),
        MapCoordinate(code: "LIB-D", type: .academic, name: "Charles C. Wise Library",latitude: 39.633197, longitude: -79.954384),
        MapCoordinate(code: "LSB-D", type: .academic, name: "Life Science Building", latitude: 39.637073, longitude: -79.95559),
        MapCoordinate(code: "LWC-E", type: .academic, name: "Law Center", latitude: 39.648602, longitude: -79.958558),
        MapCoordinate(code: "MAR-D", type: .academic, name: "Martin Hall", latitude: 39.635564, longitude: -79.954967),
        MapCoordinate(code: "MBRC-H", type: .academic, name: "Mary Bab Randolph Cancer Center", latitude: 39.654234, longitude: -79.958051),
        MapCoordinate(code: "MEC-E", type: .academic, name: "Museum Education Center", latitude: 39.645670, longitude: -79.974281),
        MapCoordinate(code: "MHH-D", type: .academic, name: "Ming Hsieh Hall", latitude: 39.636563, longitude: -79.953605),
        MapCoordinate(code: "MRB-E", type: .academic, name: "Mineral Resouces Building", latitude: 39.646646, longitude: -79.973855),
        MapCoordinate(code: "MTL-D", type: .academic, name: "Mountain Lair", latitude: 39.634769, longitude: -79.953585),
        MapCoordinate(code: "NAT-E", type: .academic, name: "Natatorium-Shell", latitude: 39.650066, longitude: -79.984071),
        MapCoordinate(code: "NIO-E", type: .academic, name: "NIOSH Building", latitude: 39.654928, longitude: -79.953951),
        MapCoordinate(code: "NRCCE", type: .academic, name: "National Research Center", latitude: 39.645265, longitude: -79.972007),
        MapCoordinate(code: "NSH-E", type: .academic, name: "North Street House", latitude: 39.645320, longitude: -79.955655),
        MapCoordinate(code: "NUR-E", type: .academic, name: "Nursery School", latitude: 39.649382, longitude: -79.978264),
        MapCoordinate(code: "OGH-D", type: .academic, name: "Oglebay Hall", latitude: 39.63614332, longitude: -79.95367751),
        MapCoordinate(code: "OWP-D", type: .academic, name: "One Waterfront Place", latitude: 39.624787, longitude: -79.963449),
        MapCoordinate(code: "PAS-E", type: .academic, name: "CPASS Building", latitude: 39.649653, longitude: -79.969059),
        MapCoordinate(code: "PER-E", type: .academic, name: "Percival Hall", latitude: 39.645802, longitude: -79.967373),
        MapCoordinate(code: "PSK-E", type: .academic, name: "Milan Pusker Stadium", latitude: 39.649100, longitude: -79.954304),
        MapCoordinate(code: "PUR-D", type: .academic, name: "Puritan House", latitude: 39.634436, longitude: -79.955086),
        MapCoordinate(code: "SRC-E", type: .academic, name: "Student Recreation Center", latitude: 39.648185, longitude: -79.970821),
        MapCoordinate(code: "RRI-D", type: .academic, name: "Regional Research Institute", latitude: 39.657042, longitude: -79.955258),
        MapCoordinate(code: "SMT-D", type: .academic, name: "Summit", latitude: 39.638754, longitude: -79.956599),
        MapCoordinate(code: "SSC-D", type: .academic, name: "Student Services Center", latitude: 39.635580, longitude: -79.953599),
        MapCoordinate(code: "STA-D", type: .academic, name: "Stansbury Hall", latitude: 39.634974, longitude: -79.956884),
        MapCoordinate(code: "STH-E", type: .academic, name: "Student Health", latitude: 39.649033, longitude: -79.969748),
        MapCoordinate(code: "USC-E", type: .academic, name: "University Services Center", latitude: 39.654098, longitude: -79.968307),
        MapCoordinate(code: "VNB-D", type: .academic, name: "Vandalia Blue", latitude: 39.638916, longitude: -79.951788),
        MapCoordinate(code: "VNG-D", type: .academic, name: "Vandalia Gold", latitude: 39.638038, longitude: -79.951686),
        MapCoordinate(code: "WHI-D", type: .academic, name: "White Hall", latitude: 39.632882, longitude: -79.954649),
        //EVC-E Evansdale Crossing
        MapCoordinate(code: "EVC-E", type: .academic, name: "Evansdale Crossing", latitude: 39.647872, longitude: -79.973245),
        MapCoordinate(code: "STL-D", type: .housing, name: "Stalnaker Hall", latitude: 39.635324, longitude: -79.952693),
        MapCoordinate(code: "SMT-D", type: .housing, name: "Summit", latitude: 39.638754, longitude: -79.956599),
        MapCoordinate(code: "SPH-D", type: .housing, name: "International House", latitude: 39.631943, longitude: -79.952475),
        MapCoordinate(code: "MCA-E", type: .housing, name: "Med Center Apartment - Building K", latitude: 39.654057, longitude: -79.961932),
        MapCoordinate(code: "MCB-E", type: .housing, name: "Med Center Apartment - Building J", latitude: 39.653888, longitude: -79.962887),
        MapCoordinate(code: "LYT-E", type: .housing, name: "Lyon Tower", latitude: 39.647870, longitude: -79.966405),
        MapCoordinate(code: "LNC-D", type: .housing, name: "Lincon Hall", latitude: 39.649402, longitude: -79.965612),
        MapCoordinate(code: "HON-D", type: .housing, name: "Honors Hall", latitude: 39.638232, longitude: -79.956504),
        MapCoordinate(code: "DAD-D", type: .housing, name: "Dadisman Dorm", latitude: 39.635676, longitude: -79.952417),
        MapCoordinate(code: "BXT-E", type: .housing, name: "Braxton Towner", latitude: 39.648432, longitude: -79.966257),
        MapCoordinate(code: "BRN-D", type: .housing, name: "Boreman Hall North", latitude: 39.633550, longitude: -79.952287),
        MapCoordinate(code: "BRS-D", type: .housing, name: "Boreman Hall South", latitude: 39.633025, longitude: -79.952418),
        MapCoordinate(code: "BRF-D", type: .housing, name: "Boreman Residential Facility", latitude: 39.632973, longitude: -79.952183),
        MapCoordinate(code: "BRT-E", type: .housing, name: "Brooke Tower", latitude: 39.648985, longitude: -79.965791),
        MapCoordinate(code: "BTT-E", type: .housing, name: "Bennett Tower", latitude: 39.648217, longitude: -79.967014),
        MapCoordinate(code: "ARN-D", type: .housing, name: "Arnold Hall", latitude: 39.632486, longitude: -79.950469),
        MapCoordinate(code: "", type: .housing, name: "University Park", latitude: 39.650447, longitude: -79.962131),
        MapCoordinate(code: "ST2", type: .parking, name: "Mountainlair Parking Garage - ST2", latitude: 39.63390982, longitude: -79.95299488),
        MapCoordinate(code: "Life Sciences", type: .parking, name: "Public Parking - ST7", latitude: 39.63751225, longitude: -79.95525867),
        MapCoordinate(code: "Mountaineer Station", type: .parking, name: "Public Parking - ST3", latitude: 39.654853595827, longitude: -79.960985183716),
        //MapCoordinate(code: "COL-D", name: "Coliseum Parking", latitude: 39.648575, longitude: -79.980191),
        MapCoordinate(code: "Honors Hall Public Parking", type: .parking, name: "Public Parking - ST5", latitude: 39.63799558, longitude: -79.95540351),
        //MapCoordinate(code: "ST10-D",name: "Business & Economics Public Parking", latitude: 39.637181, longitude: -79.953980),
        MapCoordinate(code: "Erickson Alumni Center", type: .parking, name: "Public Parking - ST8", latitude: 39.65083684, longitude: -79.96430576),
        //MapCoordinate(code: "ST9-E", name: "CAC Public Parking", latitude: 39.648516, longitude: -79.973899),
        MapCoordinate(code: "Greenhouse Public Parking", type: .parking, name: "Public Parking - ST6", latitude: 39.64504699, longitude: -79.96659368),
        MapCoordinate(code: "Ag Sciences", type: .parking, name: "Public Parking - ST4", latitude: 39.64623248, longitude: -79.96853024),
        MapCoordinate(code: "Greenhouse", type: .parking, name: "Public Parking - ST1", latitude: 39.64411345, longitude: -79.97030586),
        MapCoordinate(code: "PRT",   type: .prt, name: "PRT Station - Walnut St.", latitude: 39.6300056, longitude: -79.9572596),
        MapCoordinate(code: "PRT",   type: .prt, name: "PRT Station -  Beechurst Ave.", latitude: 39.63486415, longitude: -79.95614916),
        MapCoordinate(code: "PRT",   type: .prt, name: "PRT Station - Engineering", latitude: 39.646907, longitude: -79.973238),
        MapCoordinate(code: "PRT",   type: .prt, name: "PRT Station - Evansdale Residential Complex", latitude: 39.64756555, longitude: -79.9693054),
        MapCoordinate(code: "PRT",   type: .prt, name: "PRT Station - Health Sciences Center", latitude: 39.65508791, longitude: -79.9601993),
        MapCoordinate(code: "SRC-E", type: .recreation, name: "Student Recreation Center", latitude: 39.648185, longitude: -79.970821)]
    
    enum CoordinateType {
        case recreation, prt, parking, dining, housing, academic
        
        var color: UIColor {
            switch self {
            case .prt:
                return UIColor.brown
            case .parking:
                return UIColor.blue
            case .recreation:
                return UIColor.green
            case .dining:
                return UIColor.red
            case .housing:
                return UIColor.yellow
            case .academic:
                return UIColor.purple
            }
        }
    }
}
