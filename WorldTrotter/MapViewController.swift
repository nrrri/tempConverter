//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Narissorn Chowarun on 2024-06-17.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let pointOfInterestSwitch = UISwitch()
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        self.view = mapView
        addMapControls()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
        
    }

    
    func addLabel(text:String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.sizeToFit()
        self.view.addSubview(label)
        
        return label
    }
    
    func addSwitch() -> UISwitch {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.setOn(true, animated: true)
        toggle.addTarget(self, action: #selector(updateSwitch), for: .valueChanged)
        self.view.addSubview(toggle)
        return toggle
    }
    
    func addSegmentControl(items: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        
        return segmentedControl
    }
    
    func addMapControls() {
        let items = ["Standard", "Hybrid","Satellite"]
        
        // Create Segmant
        let segmentedControl = addSegmentControl(items: items)
        
        // Create label
        let pointOfInterestLabel = addLabel(text: "Point of interest")
        
        // Create Switch
        let pointOfInterestSwitch = addSwitch()

        // Layout
        // Segment
        let margins = view.layoutMarginsGuide
        segmentedControl.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // Label
        pointOfInterestLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16).isActive = true
        pointOfInterestLabel.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor).isActive = true
        
        // Switch
        pointOfInterestSwitch.leadingAnchor.constraint(equalTo: pointOfInterestLabel.trailingAnchor, constant: 16).isActive = true
        pointOfInterestSwitch.centerYAnchor.constraint(equalTo: pointOfInterestLabel.centerYAnchor, constant: 0).isActive = true
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl)
    {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func updateSwitch(sender: UISwitch!) {
        if pointOfInterestSwitch.isOn {
            mapView.pointOfInterestFilter = .includingAll
        } else {
            mapView.pointOfInterestFilter = .excludingAll
        }
    }

}
