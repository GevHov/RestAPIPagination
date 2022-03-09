//
//  My Results.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import Foundation

//MARK: - MyResults

class MyResults: Codable {
    
    var gender: Gender
    var name: MyName
//    var location: MyLocation
    var email: String
    var login: MyLogin
//    var dob: MyBod
//    var registered: MyBod
    var phone: String
    var cell: String
    var id: Id
    var picture: MyPicture
    var nat: String
    
}


//MARK: - Gender

enum Gender: String, Codable {
    
    case female = "female"
    case male = "male"
}
