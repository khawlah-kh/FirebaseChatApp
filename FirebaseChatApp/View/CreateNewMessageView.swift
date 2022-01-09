//
//  CreateNewMessageView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 07/12/2021.
//

import SwiftUI
import Kingfisher
struct CreateNewMessageView: View {
    @EnvironmentObject var viewModel : AuthViewModel

    @Environment(\.presentationMode) var presentation
    
    @Binding var isShownNewMessageView : Bool
     @Binding var selectedUser : User?
    @Binding var isShowingCreateNewMessageView :Bool
    
    
    var body: some View {
        NavigationView{
            
            ScrollView{
                
                
                VStack{
                    
                    ForEach(viewModel.users) {chatUser in
                        
                        if chatUser.id != viewModel.user?.id
                        {
                                
                            ChatUserView(chatUser: chatUser)
                                    .onTapGesture {
                                        selectedUser=chatUser
                                        isShownNewMessageView.toggle()
                                        isShowingCreateNewMessageView.toggle()
                                        
                                      
                                    }
                            

                            Divider()
                        }
                        
                    }
                    
                   
                    
                    
                }
                
                
                
                
                
            }
            .navigationTitle("New Message")
            .toolbar {
                               ToolbarItemGroup(placement: .navigationBarLeading) {
                                   Button {
                                       presentation.wrappedValue.dismiss()
                                   } label: {
                                       Text("Cancel")
                                   }
                               }
            }
//            .navigationBarItems(leading: Button(action: {
//                presentation.wrappedValue.dismiss()
//
//            }, label:{ Text("Cancel")}))
            .onAppear(perform: viewModel.fetchUsers
            )
            
            
            
            
            
            
        }    }
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewMessageView(isShownNewMessageView: .constant(false), selectedUser:.constant(User(dictionary: ["" : ""])), isShowingCreateNewMessageView:.constant(false))
    }
}




struct ChatUserView : View{
    
    let chatUser:User
    var body: some View{
        
        
        HStack{
            
            
            KFImage(URL(string:chatUser.profileImageUrl ))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(
                    Color(.label),lineWidth: 3)
                            .frame(width: 50, height: 50)
                            )
                .padding()
            
            Text(chatUser.userName)
                .font(.title3)
                .bold()
           
            
            Spacer()
            
            
        }
        

        
    }
    
    
    
    
}
