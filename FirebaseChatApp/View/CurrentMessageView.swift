//
//  CurrentMessageView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 03/12/2021.
//

import SwiftUI
import Kingfisher
struct CurrentMessageView: View {

    let currentMessage : CurrentMessgae
    var messgae : String {
        
        if currentMessage.fromId == currentMessage.user.id{
            
            return currentMessage.text
        }
        
        return "You: "+currentMessage.text
        
    }
    var body: some View {
        HStack{
            
            KFImage(URL(string:currentMessage.user.profileImageUrl ))
            
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(25)
                .overlay(Circle().stroke(
                    Color(.label),lineWidth: 3)
                            .frame(width: 50, height: 50)
                            )
                .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 5){
                Text(currentMessage.user.userName)
                .font(.title3)
                .bold()
               
                Text(self.messgae)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    
              
               
            }
            Spacer()
            
            Text(currentMessage.timestampString)
                .bold()
        }
        .padding()
    }
}

//struct CurrentMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentMessageView()
//    }
//}
