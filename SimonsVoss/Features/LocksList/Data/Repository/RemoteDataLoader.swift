//
//  RemoteDataLoader.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation

final class RemoteDataLoader: DataLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = DataLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                DispatchQueue.main.async {
                    completion(RemoteDataLoader.map(data, from: response))
                }
                
                
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(Error.connectivity))
                }
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try LockItemsMapper.map(data, from: response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension SvLsmData {
    func toModels() -> SvLsmData {
        return SvLsmData(buildings: self.buildings, locks: self.locks, groups: self.groups, media: self.media)
    }
}
