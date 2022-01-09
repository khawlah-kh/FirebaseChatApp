//
//  User.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 04/12/2021.
//

import SwiftUI
import Firebase
struct User : Identifiable,Hashable{
    
    let id: String
    let profileImageUrl : String
    let email : String
   // var isCurrentUser:Bool { return Auth.auth().currentUser?.uid == self.id }

    init(dictionary:[String:Any]){
        
        id = dictionary["uid"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
    var userName : String{
        return self.email.components(separatedBy: "@").first ?? self.email
    }
    
    static let users :[User] = [User(dictionary: ["uid" : "123","userName":"sara","profileImageUrl":"https://firebasestorage.googleapis.com:443/v0/b/twitterswiftui-a8508.appspot.com/o/CFC1EA29-B453-48FC-956E-7D2E0831BE6D?alt=media&token=49a4015f-25b1-4b49-8f78-b88883066c73","fullName":"sara khalid","email":"sara@gmail.com"])]
    
    
}
