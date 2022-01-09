//
//  CurrentMessagesViewModel.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 17/12/2021.
//

import Foundation
import Firebase
class CurrentMessagesViewModel:ObservableObject{
    
    @Published var CurrentMessages : [String:CurrentMessgae]=[:]
    @Published var recentMessages = [CurrentMessgae]()
    private var firestoreListener : ListenerRegistration?
    
    init(){
        
        fetchCurrentMessages()
        
        
    }
    
    func fetchCurrentMessages(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLECTION_CURRENT_MESSAGES.document(uid).collection(RECENT)
        
        //clean previouse data from previouse login (I'm not sure if it is really neccessary)
        firestoreListener?.remove()
        
        firestoreListener = query.addSnapshotListener  { snapshot, error in
            guard error == nil else {return}
            
            guard let changes = snapshot?.documentChanges else {return }
            
            changes.forEach{ change in
                let currentChatUserId = change.document.documentID
                COLECTION_USERS.document(currentChatUserId).getDocument {userDoc, error in
                    guard error == nil else { return }
                    
                    guard let userData = userDoc?.data() else {return }
                    
                    let user = User(dictionary: userData)
                    let messageData = change.document.data()
                    let currentmessage = CurrentMessgae(user: user, messagedata: messageData)
                    //
                    self.CurrentMessages[currentChatUserId] = currentmessage
                    self.recentMessages = Array(self.CurrentMessages.values)
                    self.recentMessages =  self.recentMessages.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()
                    }
                    )
                    
                    
                }
                
                
            }
            
            
        }
        
    }
    
}
