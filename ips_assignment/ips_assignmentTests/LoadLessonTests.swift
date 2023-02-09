//
//  LoadLessonTests.swift
//  ips_assignmentTests
//
//  Created by Loyd Kim on 2023-02-04.
//

import XCTest

final class LoadLessonTests: XCTestCase {
    var lessons:[Lesson]?
    override func setUpWithError() throws {
        lessons = ModelData().lessons
    }

    override func tearDownWithError() throws {
        lessons = nil
    }
    
    func loadLessonsFromURL() throws {
        ApiProvider().loadData { [self] result in
            self.lessons = result
            XCTAssertFalse(lessons!.isEmpty)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
