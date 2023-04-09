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
        Task {
            do {
                let snapper = MKMapSnapshotter(options: options)
                let snapshot = try await snapper.start()
                let dictionary: [String: Any] = [
                    "lat": Double(currentLocation.coordinate.latitude),
                    "lon": Double(currentLocation.coordinate.longitude),
                    "image": snapshot.image
                ]
                postNotification(object: dictionary)
            } catch {
                postNotification(object: ["error": error.localizedDescription])
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        postNotification(object: ["error": error.localizedDescription])
    }
}
