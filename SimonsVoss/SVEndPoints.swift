//
//  SVEndPoints.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import Foundation

class LockEndPoint  {
    private static let baseURL = "https://simonsvoss-homework.herokuapp.com"
    static let lockList: URL = URL(string: "\(LockEndPoint.baseURL)/sv_lsm_data.json")!
}
