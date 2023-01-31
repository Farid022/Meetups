////
////  ImageSaver.swift
////  Meetups
////
////  Created by Muhammad Farid Ullah on 19/01/2023.
////
//
import Foundation
import UIKit

//Save user Image to the phot library.
class ImageSaver: NSObject {

    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        }
        else {
            successHandler?()
        }
    }
}
