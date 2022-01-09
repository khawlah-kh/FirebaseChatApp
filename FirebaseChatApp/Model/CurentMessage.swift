//
//  CurentMessage.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 17/12/2021.
//
import SwiftUI
import Foundation
import Firebase
struct CurrentMessgae : Identifiable{
    
    //
    var id : String {
        
        user.id
        
    }
    
    let user:User
    let text : String
    let timestamp:Timestamp
    let fromId:String
    let toId:String
  
    
    init(user:User,messagedata:[String:Any]){
        
        
        self.user=user
        self.text = messagedata["text"] as! String
        self.timestamp = messagedata["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.fromId = messagedata["fromId"] as! String ?? ""
        self.toId = messagedata["toId"] as! String  ?? ""
        
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var detailedTimestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: timestamp.dateValue())
    }
    
}
