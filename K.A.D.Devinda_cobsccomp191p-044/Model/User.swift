//
//  user.swift
//  NIBM COVID19
//
//  Created by dasun on 9/4/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import CoreLocation

//enum AccountType: Int {
//    case passenger
//    case driver
//}

struct User {
    let firstname: String
    let lastname: String
    var email: String
    var role: String
    var location: CLLocation?
    let temperature: String
    let uid: String
    var surveyResult: Int
    let index: String
    let country: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstname = dictionary["firstname"] as? String ?? ""
        self.lastname = dictionary["lastname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.role = dictionary["role"] as? String ?? ""
        self.temperature = dictionary["temperature"] as? String ?? "0"
        self.surveyResult = dictionary["surveyResult"] as? Int ?? 0
        self.index = dictionary["index"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        
       
    }
}

