//
//  ContentView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 04/12/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {


        if viewModel.isAouthenticatting{
            
            MainMessagesView()
            
        }
        else{
            
            LoginView()
            
        }






    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
