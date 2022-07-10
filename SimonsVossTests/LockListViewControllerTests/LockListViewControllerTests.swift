//
//  LockListViewControllerTests.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 11.07.2022.
//

import XCTest
@testable import SimonsVoss

class LockListViewControllerTests: XCTestCase {

    func test_loadItemsActions_requestItemsFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadItemsCallCount, 0, "Expected no loading requests before view is loaded")
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadItemsCallCount, 1, "Expected a loading request once view is loaded")
        
        sut.simulateUserInitiatedListReload()
        XCTAssertEqual(loader.loadItemsCallCount, 2, "Expected another loading request once user initiates a reload")
        
        sut.simulateUserInitiatedListReload()
        XCTAssertEqual(loader.loadItemsCallCount, 3, "Expected yet another loading request once user initiates another reload")
    }
    
    func test_loadingFeedIndicator_isVisibleWhileLoadingFeed() {
        let (sut, loader) = makeSUT()

        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Expected loading indicator once view is loaded")

        loader.completeItemsLoading(at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Expected no loading indicator once loading completes successfully")

        sut.simulateUserInitiatedListReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Expected loading indicator once user initiates a reload")

        loader.completeItemsLoadingWithError(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Expected no loading indicator once user initiated loading completes with error")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LockListViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = LockListUIComposer.composedWith(loader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
}
