//
//  ChatLogView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 08/12/2021.
//

import SwiftUI

struct ChatLogView: View {
    
    @ObservedObject var viewModel :ChatLogViewModel
    init(chatUser:User){
      viewModel = ChatLogViewModel(chatUser: chatUser)
        
    }

    
    var body: some View {
      
        VStack{

            if #available(iOS 15.0, *) {
                ScrollView{
                    ScrollViewReader { scrollViewProxy in
                    VStack{
                        ForEach(viewModel.chatMessages){ chatMessage in
                            ChatBubbleView(message: chatMessage)
                        }
                        HStack{ Spacer() }
                        .id("empty")
                    }
                    .onReceive(viewModel.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            scrollViewProxy.scrollTo("empty", anchor: .bottom)
                        }
                }
                }
                }
                .background(Color(.init(white: 0, alpha: 0.05)))
                
                .safeAreaInset(edge: .bottom) {
                    ChatBottomBarView(viewModel:viewModel)
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .navigationTitle("\(viewModel.chatUser.userName)")
     
        
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: User.users[0])
    }
}
