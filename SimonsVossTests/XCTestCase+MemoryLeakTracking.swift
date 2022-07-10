//
//  XCTestCase+MemoryLeakTracking.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 10.07.2022.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
