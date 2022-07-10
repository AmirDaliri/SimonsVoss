//
//  LockListAPIEndToEndTests.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 10.07.2022.
//

import XCTest
@testable import SimonsVoss

class LockListAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETItemsResult_matchesFixedTestAccountData() {
        switch getItemsResult() {
        case let .success(data)?:
            XCTAssertEqual(data.buildings.count, 4, "Expected 4 items in the response")
            XCTAssertEqual(data.locks.count, 48, "Expected 48 items in the response")
            XCTAssertEqual(data.buildings[0], expectedBuilding(at: 0).buildings.first)
            XCTAssertEqual(data.buildings[1], expectedBuilding(at: 1).buildings.first)
            XCTAssertEqual(data.buildings[2], expectedBuilding(at: 2).buildings.first)
            XCTAssertEqual(data.buildings[3], expectedBuilding(at: 3).buildings.first)
        case let .failure(error)?:
            XCTFail("Expected successful result, got \(error) instead")
        default:
            XCTFail("Expected successful result, got no result instead")
        }
    }

    // MARK: - Helpers

    private func getItemsResult(file: StaticString = #file, line: UInt = #line) -> DataLoader.Result? {
        let testServerURL = LockEndPoint.lockList
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteDataLoader(url: testServerURL, client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)

        let exp = expectation(description: "Wait for load completion")

        var receivedResult: DataLoader.Result?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 60.0)

        return receivedResult
    }

    private func expectedBuilding(at index: Int) -> SvLsmData {
        return SvLsmData(
            buildings: [
                Building(
                    id: id(at: index),
                    shortCut: shortCut(at: index),
                    name: name(at: index),
                    description: description(at: index))],
            locks: [],
            groups: [],
            media: [])
    }

    private func id(at index: Int) -> String {
        return [
            "0cccab2b-bc8d-44c5-b248-8a9ca6d7e899",
            "9605186f-7eb4-4f40-967e-2885d9a8b3c4",
            "3116849e-e18d-4afd-8058-156d8d96b593",
            "9a168210-ae8b-4cbe-b5f9-aa8b36dd5e70"
        ][index]
    }

    private func shortCut(at index: Int) -> String {
        return [
            "HOFF",
            "PROD",
            "LOG-1",
            "LOG-2"
        ][index]
    }

    private func name(at index: Int) -> String {
        return [
            "Head Office",
            "Produktionsstätte",
            "Logistikzentrum I",
            "Logistikzentrum II"
        ][index]
    }

    private func description(at index: Int) -> String {
        return [
            "Head Office, Feringastraße 4, 85774 Unterföhring",
            "Produktionsstätte, Lindauer Str. 6, 06721 Osterfeld",
            "Logistikzentrum, 81677 München",
            "Logistikzentrum, 81335 München"
        ][index]
    }
}
