//
//  NewMessageViewModel.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 04/12/2021.
//

import Foundation
import Firebase


class AuthViewModel : ObservableObject{
    
    @Published var isAouthenticatting = false
    
    @Published var user : User?
    
    @Published var users : [User] = []

    init(){
        
//        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    
    func fetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid  else {
            
            return
        }
     
        
        COLECTION_USERS.document(uid).getDocument { snapshot, _ in
            
            guard let data = snapshot?.data() else{
                print("No data")
                return}
            
            self.user = User(dictionary: data)
           
        }
        
     
}
    
    
    func fetchUsers(){
        
        
        COLECTION_USERS.getDocuments { snapshot, error in
            
            
            guard error == nil else {
                
                return
                
            }
            
            if let data = snapshot?.documents
            {
                
                self.users = data.map({ doc in
                    User(dictionary: doc.data())
                })
                
            }
                
            
            
            
            
        }
        
        
    }
    
    func handleSignout (){
        
        try? Auth.auth().signOut()
        self.isAouthenticatting.toggle()
        self.user=nil
        
    }
    
}
