



//
//  MainMessageView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 03/12/2021.
//

import SwiftUI
import Kingfisher
import Firebase

struct MainMessagesView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject var currentMessagesViewModel = CurrentMessagesViewModel()

    @State var isShowingActionSheet = false
    @State var isShowingCreateNewMessageView = false
    
    @State var isShowingChatLogView = false
    @State var selectedUser : User?
    
    
    var body: some View {


        NavigationView{


            ScrollView{

                
                
              if let user = selectedUser{

                NavigationLink(
                    destination: ChatLogView(chatUser: selectedUser!),
                   isActive: $isShowingChatLogView,
                   label: {

                   })
               }

                
                
                VStack{

                    if !currentMessagesViewModel.recentMessages.isEmpty{
                    ForEach(currentMessagesViewModel.recentMessages){ message in
                        
                        NavigationLink {
                            LazyView(ChatLogView(chatUser: message.user ))
                        } label: {
                            CurrentMessageView(currentMessage: message)
                                .foregroundColor(Color(.label))
                        }

                       
                        Divider()
                        
                    }



                }
                    else{
                        
                        
                        VStack{
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            Text("You Don't have any Messages yet")
                                .foregroundColor(.gray)
                        }
                    }
                }

                .actionSheet(isPresented: $isShowingActionSheet, content: {
                    .init(title: Text("Settings"),
                          message:  Text("What do you want to do?"),
                          buttons: [.destructive(Text("Sign out"),
                                                 action: {
                        
                    
                        viewModel.handleSignout()

                    })
                                    ,.cancel()])  })
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: leftNavigationItem,
                                        trailing:  rightNavigationItem)}
            
            .overlay(
                newMessageButton
                ,alignment: .bottom
            )
            
        }
        .fullScreenCover(isPresented: $isShowingCreateNewMessageView) {
            CreateNewMessageView(isShownNewMessageView:$isShowingChatLogView, selectedUser: $selectedUser, isShowingCreateNewMessageView: $isShowingCreateNewMessageView)
            
        }
  
    }

    
    var newMessageButton : some View {
        Button(action:{
            
            self.isShowingCreateNewMessageView.toggle()
            
            
        } , label: {
            
            HStack{
                Spacer()
            Text("+ New Message")
                    .bold()
                .foregroundColor(.white)
                .padding()
                Spacer()
        }
            .background(Color.blue)
            .cornerRadius(30)
            .padding()
            .shadow(radius: 10)
            
        })
    }
    
    var rightNavigationItem : some View{
        Button {
            isShowingActionSheet.toggle()
        } label: {
            Image(systemName: "gearshape")
                .foregroundColor(Color(.label))
        }


    }

    var leftNavigationItem : some View{

        HStack{

            

            KFImage(URL(string:viewModel.user?.profileImageUrl ?? "" ))
            
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 38, height: 38)
                .overlay(Circle().stroke(
                    Color(.label),lineWidth: 3)
                            .frame(width: 38, height: 38)
                            )
                .shadow(radius: 5)
            VStack(alignment:.leading,spacing: 2){

             
                Text(viewModel.user?.userName ?? "")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(.label))
                HStack{
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 8, height: 8)

                    Text("online")
                        .font(.caption)
                    Spacer()
                }

            }

        }
        //.padding()

    }

}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
