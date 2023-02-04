//
//  ModelData.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import Foundation
import Combine

final class ModelData {
    var lessons: [Lesson] = load("lessonData.json")
}

func load<T: Decodable>(_ filename: String) -> [T] {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = try JSONDecoder().decode([String:[T]].self, from: data)
        return decoder["lessons"] ?? []
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
