//
//  ChatBottomBarView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 10/12/2021.
//

import SwiftUI

struct ChatBottomBarView: View {
   
   var viewModel :ChatLogViewModel
    
  

  @State var message : String = ""
    var body: some View {
        HStack(spacing:16){
            
            Button {
               
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.label))
            }

            
       TextField("Description", text: $message)
            Button {
                viewModel.handelSend(text: message)
                self.message=""
            } label: {
                Text("Send")
                   
            }

            
            
            
            
        }
        .padding()
        .background(Color(.systemBackground)
                        .ignoresSafeArea())
    }
}

struct ChatBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBottomBarView(viewModel: ChatLogViewModel(chatUser: User(dictionary: ["" : ""])))
    }
}

