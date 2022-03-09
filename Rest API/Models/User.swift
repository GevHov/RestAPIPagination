//
//  User.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import Foundation

//MARK: - USER

class User: Codable {
    
    var results: [MyResults]
    var info: MyInfo
    
}

//MARK: - MyInfo

class MyInfo: Codable {
    
    var seed: String
    var results: Int
    var page: Int
    var version: String
    
}
