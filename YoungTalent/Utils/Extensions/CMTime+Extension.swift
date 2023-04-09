//
//  CMTime+Extension.swift
//  YoungTalent
//
//  Created by admin on 9.04.2023.
//

import CoreMedia

extension CMTime {
    var durationText: String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let hours = Int(totalSeconds / 3600)
        let minutes = Int(totalSeconds % 3600 / 60)
        let seconds = Int((totalSeconds % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
