//
//  Notific.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

struct Notific {
    let id: String
    let title: String
    let description: String
    let date: Int
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.date = dictionary["email"] as? Int ?? 0
    }
}
