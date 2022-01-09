//
//  FirebaseChatAppApp.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 29/11/2021.
//

import SwiftUI
import Firebase
@main
struct FirebaseChatAppApp: App {
  
    init(){
        
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            
            ContentView().environmentObject(AuthViewModel())

           
        }
    }
}
