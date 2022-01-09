//
//  ChatBubbleView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 10/12/2021.
//

import SwiftUI

struct ChatBubbleView: View {
    let message : ChatMessage
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack{
        if message.fromId == viewModel.user?.id{
        HStack{
            Spacer()
            Text(message.text)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.horizontal)
        }
           
        }
        else{
            
            HStack{
                Text(message.text)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                Spacer()
            }
            
            
            
        }
        
    }
    }
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleView(message: ChatMessage(documentId: "123", dictionary: ["" : ""]))
    }
}
