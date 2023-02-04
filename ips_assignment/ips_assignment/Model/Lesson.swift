//
//  Lesson.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import Foundation
import SwiftUI

struct Lesson: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var description: String
    var video_url: String
    var thumbnail: String
    
    var thumbnailImage: Image {
        Image(thumbnail)
    }
}
