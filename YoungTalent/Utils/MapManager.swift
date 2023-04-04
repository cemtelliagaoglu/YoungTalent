//
//  MapManager.swift
//  YoungTalent
//
//  Created by admin on 4.04.2023.
//

import MapKit

extension NSNotification.Name {
    static let sharedLocation = NSNotification.Name("sharedLocation")
}

class MapManager: NSObject, CLLocationManagerDelegate {
    // MARK: - Properties

    static let shared = MapManager()
    private let notificationCenter = NotificationCenter.default
    private let locationManager = CLLocationManager()

    // MARK: - Lifecycle

    override private init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: - Methods

    func isAuthorized() -> Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse
    }

    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestCurrentLocation() {
        if isAuthorized() {
            locationManager.requestLocation()
        } else {
            requestPermission()
        }
    }

    func postNotification(object: [String: Any]) {
        notificationCenter.post(name: .sharedLocation, object: object)
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let options = MKMapSnapshotter.Options()
        options.region = .init(
            center: .init(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude
            ),
            span: .init(latitudeDelta: 1 / 100, longitudeDelta: 1 / 100)
        )

        let snapper = MKMapSnapshotter(options: options)
        snapper.start { [weak self] snapshot, error in
            if let error {
                print(error.localizedDescription)
            } else {
                guard let image = snapshot?.image else { return }
                let dictionary: [String: Any] = [
                    "lat": Double(currentLocation.coordinate.latitude),
                    "lon": Double(currentLocation.coordinate.longitude),
                    "image": image
                ]
                self?.postNotification(object: dictionary)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
