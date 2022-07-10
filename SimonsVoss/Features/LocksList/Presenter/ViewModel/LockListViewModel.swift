//
//  LockListViewModel.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation
import Combine

public class LockListViewModel {
    private let loader: DataLoader

    // MARK: - Properties
    public var onLoadingStateChange = PassthroughSubject<Bool, Never>()
    public var errorMessage = PassthroughSubject<String, Never>()
    public var onItemsLoad: (() -> Void)?
    public private(set) var lockItems: [LockItem] = [] {
        didSet {
            self.onItemsLoad?()
        }
    }
    private var allItem: [LockItem] = []

    // MARK: - Initializer
    public init(loader: DataLoader) {
        self.loader = loader
    }
    
    // MARK: - API Method
    public func loadItems() {
        onLoadingStateChange.send(true)
        loader.load { [weak self] result in
            switch result {
            case .success(let data):
                self?.allItem = self?.mapToItems(data: data) ?? []
                self?.lockItems = self?.allItem ?? []
            case .failure(let error):
                self?.errorMessage.send(error.localizedDescription)
            }
            self?.onLoadingStateChange.send(false)
        }
    }
    
    // MARK: - Search Method
    public func search(searchText: String) {
        
        if searchText.isEmpty {
            self.lockItems = allItem
        }else {
            let filteredData = allItem.filter { item in
                if item.buildingName.localizedCaseInsensitiveContains(searchText) ||
                    item.buildingShortcut.localizedCaseInsensitiveContains(searchText) ||
                    item.name.localizedCaseInsensitiveContains(searchText) ||
                    item.floor.localizedCaseInsensitiveContains(searchText) ||
                    item.roomNo.localizedCaseInsensitiveContains(searchText) {
                    return true
                }
                return false
            }
            self.lockItems = filteredData
        }
    }
}

// MARK: - Helpers
private extension LockListViewModel {
    private func mapToItems(data: SvLsmData) -> [LockItem] {
        return data.locks.map { lock -> LockItem in
            let building = data.getBuilding(by: lock.buildingID)
            
            return LockItem(name: lock.name,
                            buildingShortcut: building?.shortCut ?? "",
                            buildingName: building?.name ?? "",
                            floor: lock.floorNo ?? "",
                            roomNo: lock.roomNumber)
        }
    }
}
