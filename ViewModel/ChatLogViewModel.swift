//
//  ChatLogViewModel.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 11/12/2021.
//

import Foundation
import Firebase
import SwiftUI
class ChatLogViewModel:ObservableObject{
    
    
    @Published var chatMessages : [ChatMessage] = []
    
    @Published var CurrentMessages : [User:ChatMessage]=[:]
    

     var firestoreListener : ListenerRegistration?
    
     var chatUser : User
    
    @Published var count = 0
    init(chatUser:User){
        
        self.chatUser=chatUser
        fetchMessages()
        
    }
    
    func handelSend(text:String){
        
        guard let fromId = Auth.auth().currentUser?.uid else {return}
       let document = COLECTION_MESSAGES.document(fromId).collection(chatUser.id).document()

        let messageData:[String : Any] = ["fromId":fromId,"toId":chatUser.id,"text":text,"timestamp":Timestamp()]
        
        document.setData(messageData){ error in
            if let error = error {
                print ("Failt to upload message into firestore \(error)")
                return
            }
            print("Message has been uploaded successfully")
            
            self.count += 1
            
        }

        let recipientMessageDocument = COLECTION_MESSAGES
                    .document(chatUser.id)
                    .collection(fromId)
                    .document()

                recipientMessageDocument.setData(messageData) { error in
                    if let error = error {
                        print(error)
                        return
                    }

                    print("Recipient saved message as well")
                }
        
        //
        let currentMessageData :[String : Any] = ["text":text,"timestamp":Timestamp(),"fromId":fromId,"toId":chatUser.id]
        
        COLECTION_CURRENT_MESSAGES.document(fromId).collection(RECENT).document(chatUser.id).setData(currentMessageData)
        COLECTION_CURRENT_MESSAGES.document(chatUser.id).collection(RECENT).document(fromId).setData(currentMessageData)

        
    }
    
    func fetchMessages(){
    
        //firestoreListener?.remove()
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        
        firestoreListener=COLECTION_MESSAGES
            .document(fromId)
            .collection(chatUser.id)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                
                if let error = error{
                    
                    print("Something went wrong")
                    return
                }
                
                
                snapshot?.documentChanges.forEach({ documentChange in
                    if documentChange.type == .added {
                    let data = documentChange.document.data()
                    self.chatMessages.append( ChatMessage(documentId:documentChange.document.documentID , dictionary: data) )
                      
                    }
                })
             
                DispatchQueue.main.async {
                    self.count += 1
                }
              
                
             
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
