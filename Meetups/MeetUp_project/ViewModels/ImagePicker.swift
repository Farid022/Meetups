//
//  ImagePicker.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation
import UIKit
import SwiftUI

//Pop up a sheet and show the phots, enable selecetion, handle cancel etc.
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //picker.dismiss(animated: true)
            
            // Camera
            if let editedImage = info[.editedImage] as? UIImage {
                self.parent.image = editedImage
            }
            
            // Photo library
            if let image = info[.originalImage] as? UIImage {
                self.parent.image = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = sourceType == .camera ? true : false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    //typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
