//
//  ChatMessage.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 12/12/2021.
//

import Foundation



struct ChatMessage : Identifiable{
    var id  :String {documentId} 
    let fromId : String
    let toId : String
    let text : String
    
    let documentId:String
    
    
    init(documentId:String,dictionary:[String:Any]){
        
        fromId = dictionary["fromId"] as? String ?? ""
        toId = dictionary["toId"] as? String ?? ""
        text = dictionary["text"] as? String ?? ""
        self.documentId=documentId
       
        
        
    }
    
   
    
}
