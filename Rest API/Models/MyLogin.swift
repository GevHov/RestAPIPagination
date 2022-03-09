//
//  MyLogin.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import Foundation

//MARK: - MyLogin

class MyLogin: Codable {
    
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
    
}
