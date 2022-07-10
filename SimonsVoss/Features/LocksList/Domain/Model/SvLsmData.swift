//
//  SvLsmData.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation

// MARK: - SvLsmData
public struct SvLsmData: Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case buildings
        case locks
        case groups
        
        /// Its under comment because not necessary to parsing for now
        /*
         case buildingID = "buildingId"
         case type, name
         case lockDescription = "description"
         case serialNumber, floor, roomNumber
         */
    }
    
    public init(from decoder: Decoder) {
        let containet = try? decoder.container(keyedBy: CodingKeys.self)
        buildings = (try? containet?.decode([Building].self, forKey: .buildings)) ?? []
        locks = (try? containet?.decode([Lock].self, forKey: .locks)) ?? []
        groups = []
        media = []
    }
    
    let buildings: [Building]
    let locks: [Lock]
    let groups: [Building]
    let media: [Media]
    
    
    init(buildings: [Building], locks: [Lock], groups: [Building], media: [Media]) {
        self.buildings = buildings
        self.locks = locks
        self.groups = groups
        self.media = media
    }
    
    func getBuilding(by id: String) -> Building? {
        return buildings.first(where: {$0.id == id})
    }
}

// MARK: - Building
struct Building: Decodable, Equatable {
    let id: String
    let shortCut: String
    let name: String
    let description: String
}

// MARK: - Lock
struct Lock: Decodable, Equatable {
    let id, buildingID: String
    let type: LockType
    let name: String
    let lockDescription: String?
    let serialNumber: String
    let floorNo: String?
    let roomNumber: String

    enum CodingKeys: String, CodingKey {
        case id
        case buildingID = "buildingId"
        case type, name
        case lockDescription = "description"
        case floorNo = "floor"
        case serialNumber, roomNumber
    }
}

enum LockType: String, Decodable {
    case cylinder = "Cylinder"
    case smartHandle = "SmartHandle"
}

// MARK: - Media
struct Media: Decodable, Equatable {
    let id, groupID: String
    let type: String
    let owner: String
    let mediaDescription: String?
    let serialNumber: String

    enum CodingKeys: String, CodingKey {
        case id
        case groupID = "groupId"
        case type, owner
        case mediaDescription = "description"
        case serialNumber
    }
}
