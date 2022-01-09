//
//  ContentView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 29/11/2021.
//

import SwiftUI
import Firebase


struct LoginView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    @State var isShowingAlert = false
        
    @State var isValidUser = false
    @State var isLoginMode = false
    @AppStorage("email") var email = ""
    @State var password = ""
    @State var selectedUIImage : UIImage?
    @State var image : Image?
    
    @State var isShowingImagePicker = false
  
    @State var loginStatusMessage = ""
    var body: some View {
          
        NavigationView{
            ScrollView{
                VStack{
                Picker("", selection: $isLoginMode) {
                    Text("Login").tag(true)
                    Text("Create Account").tag(false)
                     
                }
                .pickerStyle(.segmented)
               
                
                    if !isLoginMode{
                        
                        
                     
                Button {
                    isShowingImagePicker.toggle()
                } label: {
                    
                    
                    if let image = image {
                        
                        image.resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                        
                    }
                    else{
                    Image(systemName: "person.fill")
                        .font(.system(size: 80))
                        .scaledToFill()
                        .foregroundColor(Color(.label))
                        .frame(width: 150, height: 150)
                        
                    
                }
                    
                        }
                        
                .overlay(Circle().stroke(
                    Color(.label),lineWidth: 3)
                            .frame(width: 150, height: 150)
                            )
                        
                .padding()
                    }
                TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        
                    .padding()
                    .background(Color.white)
                    .padding(.top)
                   
                    SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    
                
                Button {
                    handelAction()
                } label: {
                    HStack{
                        Spacer()
                        Text(isLoginMode ? "Log in" : "Creat Account")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        Spacer()
                    
                    }
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding(.vertical)
                   
                }

                Text(loginStatusMessage)
                
                
            }
                .navigationTitle(isLoginMode ? "Log In" : "Create Acount")
            
           
                
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: $selectedUIImage)
            })
            .alert(isPresented: $isShowingAlert) {
                   Alert(
                       title: Text("Ops!"),
                       message: Text("You need to select an image ")
                   )
               }
            
        }
        
    }
    
    func loadImage(){
        guard let selectedImage=selectedUIImage else {return}
        
        image = Image(uiImage: selectedImage)
        
    }
    
    private func handelAction(){
        
        if isLoginMode{
            
            logInUser()
        }
        else{
            createNewAccount()
            
        }
        
        
    }
    
    
    private func logInUser(){

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                print("Faild to sign in",error)
                
            }
            else{
                viewModel.fetchUser()
                viewModel.isAouthenticatting.toggle()
                //maybe should call fetchRecentMessages
                print("Hello \( result?.user.email ?? "")")
               
                
            }
        }
    }
    
    private func createNewAccount(){
        
        if self.image == nil {
            
            
            self.isShowingAlert.toggle()
            return 
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error{
                
                
                print("Faild to create a new account",error)
                return
            }
            else{


                print("Successfully created user \( result?.user.uid ?? "")")
               
                
            }
            
            
            persistImageToStorage()
            
            
            
            
        }
      
        
        
    }
    
    
    
    private func persistImageToStorage() {
        
        //return user id (String)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //allocate a place in the storage and refere to it by uid
        let ref = Storage.storage().reference(withPath: uid)
        
        //Conver the image into data
        guard let imageData = self.selectedUIImage?.jpegData(compressionQuality: 0.5) else { return }
        
        //put that data in the storage
           ref.putData(imageData, metadata: nil) { metadata, err in
               if let err = err {
                   self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                   return
               }

               ref.downloadURL { url, err in
                   if let err = err {
                       self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                       return
                   }

                   self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                   self.loginStatusMessage="url for the image :\(url?.absoluteString)"
                   
                   //Complete the process by store user data in firestore
                   guard let url=url else{return}
                   
                   storeUserInformation(imageURL: url )
               }
           }
       }
    
    
    
    
    private func storeUserInformation(imageURL : URL){
        
        guard let uid = Auth.auth().currentUser?.uid else { return  }
        let userData = ["email":self.email,
                        "uid":uid,
                        "profileImageUrl":imageURL.absoluteString
        ]
        COLECTION_USERS.document(uid).setData(userData) { error in
            if let error = error {
                
                print(error)
                self.loginStatusMessage=error.localizedDescription
                return
                
                
            }
            
            print("Sucssessfully added to firestore")
            viewModel.fetchUser()
            viewModel.isAouthenticatting.toggle()
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
