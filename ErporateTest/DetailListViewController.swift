//
//  DetailListViewController.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SDWebImage

class DetailListViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textDesk: UITextView!
    @IBOutlet weak var mapView: GMSMapView!
    var modelData: [ModelData] = []
    var locationManager = CLLocationManager()
    var mainMarker: GMSMarker!
    var address: String = ""
    
    var stringLat: Double = 0
    var strinLon: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detail List"
        
        setupSubView()
        setupMapViews()
        setupLocation()
        getLocationFromAddress()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //imageTitle.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))
    func setupSubView() {
        for data in modelData {
            imageTitle.sd_setImage(with: URL(string: data.gambarPariwisata), placeholderImage: UIImage(named: "placeholder"))
            labelTitle.text = data.namaPariwisata
            textDesk.text = data.detailPariwisata
        }
    }
    
    func getLocationFromAddress()  {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            self.stringLat = lat != nil ? lat! : 0
            self.strinLon = lon != nil ? lon! : 0
            self.setupLocation()
        }
    }
    
    func setupMapViews() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = false
        mapView.isUserInteractionEnabled = false
    }
    
    func setupLocation() {
        let camera = GMSCameraPosition.camera(withLatitude: stringLat,
                                              longitude: strinLon,
                                              zoom: 15.0)
        self.mapView.animate(to: camera)
        mapView.isUserInteractionEnabled = false
        styleMaps(maps: mapView)
        
        let mainIconView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 58.0, height: 68.0))
        mainIconView.image = UIImage.init(named: "map-marker")
        mainIconView.contentMode = .scaleAspectFit
        
        mainMarker = GMSMarker()
        mainMarker.position = CLLocationCoordinate2D(latitude: stringLat, longitude: strinLon)
        mainMarker.iconView = mainIconView
        mainMarker.map = mapView
        
        locationManager.stopUpdatingLocation()
    }
    
    func styleMaps(maps: GMSMapView) {
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "mapStyle1", withExtension: "json") {
                maps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("Map styles failed to load. \(error)")
        }
    }

}

// MARK: - CLLocationManagerDelegate
extension DetailListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        setupLocation()
    }
}
