//
//  LockListViewControllerTests+LoaderSpy.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 11.07.2022.
//

import Foundation
@testable import SimonsVoss

extension LockListViewControllerTests {
    
    class LoaderSpy: DataLoader {
        // MARK: - DataLoader
        
        private var dataRequests = [(DataLoader.Result) -> Void]()
        
        var loadItemsCallCount: Int {
            return dataRequests.count
        }
        
        func load(completion: @escaping (DataLoader.Result) -> Void) {
            dataRequests.append(completion)
        }
        
        func completeItemsLoading(with data: SvLsmData = SvLsmData(buildings: [], locks: [], groups: [], media: []), at index: Int = 0) {
            dataRequests[index](.success(data))
        }
        
        func completeItemsLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            dataRequests[index](.failure(error))
        }

    }
}
