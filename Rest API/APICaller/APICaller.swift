//
//  APICaller.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import Foundation

class APICaller {
    
    var isPaginating = false
    func fetchData(pagination: Bool = false, complation: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            
            let originalData = ["Facebook",
                                "Twitter",
                                "Instagram",
                                "Tik-Tok",
                                "Facebook",
                                "Twitter",
                                "Instagram",
                                "Tik-Tok",
                                "Facebook",
                                "Twitter",
                                "Instagram",
                                "Tik-Tok"]
            
            let newData = ["orange","blue","yellow","green","black"]
            
            complation(.success(pagination ? newData: originalData))
            
            if pagination {
                self.isPaginating = false
            }
        })
    }
}

