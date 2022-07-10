//
//  LockItemsMapper.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation

final class LockItemsMapper {
    private struct Root: Decodable {
        let items: SvLsmData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> SvLsmData {
        guard response.isOK, let root = try? JSONDecoder().decode(SvLsmData.self, from: data) else {
            throw RemoteDataLoader.Error.invalidData
        }

        return root
    }
}

private extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
