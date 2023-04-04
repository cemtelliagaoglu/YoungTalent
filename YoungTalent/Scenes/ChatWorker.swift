//
//  ChatWorker.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

protocol ChatWorkingLogic: AnyObject {
    func getCurrentLocation(completion: @escaping ((Chat.Case.Location) -> Void))
}

final class ChatWorker: ChatWorkingLogic {
    private let mapManager = MapManager.shared
    private let notificationCenter = NotificationCenter.default

    func getCurrentLocation(completion: @escaping ((Chat.Case.Location) -> Void)) {
        mapManager.requestCurrentLocation()
        notificationCenter.addObserver(
            forName: .sharedLocation,
            object: nil,
            queue: .main
        ) { notification in
            guard let location = notification.object as? [String: Any],
                  let longitude = location["lon"] as? Double,
                  let latitude = location["lat"] as? Double
            else { return }
            completion(.init(longitude: longitude, latitude: latitude))
        }
    }
}
