//
//  ContactAPI.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/17/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

class ContactAPI {
 static func getContacts() -> [Contact]{
   let contacts = [
     Contact(name: "Kelly Goodwin", jobTitle: "Designer", country: "bo"),
     Contact(name: "Mohammad Hussain", jobTitle: "SEO Specialist", country: "be"),
     Contact(name: "John Young", jobTitle: "Interactive Designer", country: "af"),
     Contact(name: "Tamilarasi Mohan", jobTitle: "Architect", country: "al"),
     Contact(name: "Kim Yu", jobTitle: "Economist", country: "br"),
     Contact(name: "Derek Fowler", jobTitle: "Web Strategist", country: "ar"),
     Contact(name: "Shreya Nithin", jobTitle: "Product Designer", country: "az"),
     Contact(name: "Emily Adams", jobTitle: "Editor", country: "bo"),
     Contact(name: "Aabidah Amal", jobTitle: "Creative Director", country: "au")
    ]
   return contacts
  }
}
