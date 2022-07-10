//
//  DataLoader.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation

public protocol DataLoader {
    typealias Result = Swift.Result<SvLsmData, Error>
    
    func load(completion: @escaping (Result) -> Void)
}
