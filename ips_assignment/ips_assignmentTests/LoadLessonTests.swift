//
//  LoadLessonTests.swift
//  ips_assignmentTests
//
//  Created by Loyd Kim on 2023-02-04.
//

import XCTest

final class LoadLessonTests: XCTestCase {
    private var lessons:[Lesson]?
    
    override func setUpWithError() throws {
        lessons = ModelData().lessons
    }

    override func tearDownWithError() throws {
        lessons = nil
    }
    
    func testLoadLessonsFromURL() async throws {
        let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons")!
        
        let dataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url, delegate: nil)
        
        let httpResponse = try XCTUnwrap(dataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
        XCTAssertEqual(httpResponse.statusCode, 200, "Expected a 200 OK response.")
        
        if let decoder = try? JSONDecoder().decode([String:[Lesson]].self, from: dataAndResponse.data)
        {
            let lessons:[Lesson] = decoder["lessons"] ?? []
            XCTAssertEqual(lessons.count, 11)
        }else{
            XCTAssertThrowsError("Decoder is not Lesson list type")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
