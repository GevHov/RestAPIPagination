//
//  MyLocation.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import Foundation

//MARK: - MyLocation

class MyLocation: Codable {
    
    var street: MyStreet
    var city: String
    var state: String
    var country: String
    var postcode: Int
    var coordinates: MyCoordinates
    
}
