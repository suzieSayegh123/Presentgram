//
//  CameraView.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI


struct CameraView: View {
    
    
    
    @ObservedObject var cameraViewModel = CameraViewModel()

    func sharePost() {
       // cameraViewModel.uploadPost
        cameraViewModel.sharePost(completed: {
           print("done")
           self.clean()
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
           self.cameraViewModel.showAlert = true
           self.cameraViewModel.errorString = errorMessage
           self.clean()
        }
    }
    
    func clean() {
        self.cameraViewModel.caption = ""
        self.cameraViewModel.image = Image(systemName: IMAGE_PHOTO)
        self.cameraViewModel.imageData = Data()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    cameraViewModel.image.resizable().scaledToFill().frame(width: 100, height: 100).clipped().foregroundColor(.gray).onTapGesture {
                            print("Tapped")
                            self.cameraViewModel.showImagePicker = true
                    }
                    Spacer(minLength: 20)
                    TextField("Description...", text: $cameraViewModel.caption).padding(.top, 35).font(.system(size: 25))
               }.padding()
                Spacer()
            }.sheet(isPresented: $cameraViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$cameraViewModel.showImagePicker, pickedImage: self.$cameraViewModel.image, imageData: self.$cameraViewModel.imageData)
            }.navigationBarTitle(Text("Add A Present"), displayMode: .inline).navigationBarItems(trailing: Button(action: sharePost) {
                
                Image(systemName: "eject").imageScale(Image.Scale.large)
            }.alert(isPresented: $cameraViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.cameraViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            ).foregroundColor(.black)
        }
        
       
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
