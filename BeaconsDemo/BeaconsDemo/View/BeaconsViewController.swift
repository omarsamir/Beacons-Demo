//
//  BeaconsViewController.swift
//  BeaconsDemo
//
//  Created by Admin on 4/11/19.
//  Copyright © 2019 Sure. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconsViewController: UIViewController {
    typealias Beacons = [CLBeacon]
    @IBOutlet weak var beaconsTableView: UITableView!
    var beacons = Beacons()
    var beaconRegion: CLBeaconRegion!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconsTableView.delegate = self
        self.beaconsTableView.dataSource = self
        
//        self.beaconsTableView.register(BeaconCell.self, forCellReuseIdentifier: String(describing: BeaconCell.self))
        
        self.beaconsTableView.register(UINib(nibName: String(describing: BeaconCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BeaconCell.self))
        
        self.beaconRegion =  CLBeaconRegion(proximityUUID:  UUID (uuidString: Constants.BEACON_UUID) ?? UUID() ,
                                            major:  Constants.BEACON_MAJOR,
                                            minor:  Constants.BEACON_MINOR,
                                            identifier:  Constants.BEACON_NAME)
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        self.startMonitorBeacons()
        // Do any additional setup after loading the view.
    }
    
    func startMonitorBeacons(){
       locationManager.startMonitoring(for: self.beaconRegion)
       locationManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func stopMonitorBeacons(){
        locationManager.stopMonitoring(for: self.beaconRegion)
        locationManager.stopRangingBeacons(in: self.beaconRegion)
    }
    
}

extension BeaconsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BeaconCell.self), for: indexPath) as! BeaconCell
        let beacon: CLBeacon = beacons[indexPath.row]
        cell.beaconUUID.text = beacon.proximityUUID.uuidString
        cell.beaconMinorAndMajor.text = "Minor: " + beacon.minor.stringValue + "/" + "Major: " + beacon.major.stringValue
        cell.otherInfo.text = "Prox: " + String(beacon.proximity.rawValue) + " - Acc: " + String(beacon.accuracy)
        return cell
    }
    
    
}
extension BeaconsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension BeaconsViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        self.beacons = beacons
        beaconsTableView.reloadData()
    }
}
