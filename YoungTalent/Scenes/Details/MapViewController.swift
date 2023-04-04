//
//  MapViewController.swift
//  YoungTalent
//
//  Created by admin on 4.04.2023.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    // MARK: - Properties

    var viewModel: Chat.Case.Location?

    @IBOutlet var mapView: MKMapView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        guard let location = viewModel else { return }
        let center = CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude
        )
        mapView.region = .init(
            center: center,
            span: .init(
                latitudeDelta: 1 / 100,
                longitudeDelta: 1 / 100
            )
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
