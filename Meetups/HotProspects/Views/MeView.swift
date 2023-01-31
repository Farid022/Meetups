//
//  MeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/01/2023.
//

import SwiftUI
//Core Image lets us generate a QR code from any input string.
import CoreImage.CIFilterBuiltins // Core Image filters
import CoreImage

//ask the user to enter their name and email address in a form, use those two pieces of information to generate a QR code identifying them

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "Farid@icloud.com"
    
    let context = CIContext()//to store an active Core Image context.
    let filter = CIFilter.qrCodeGenerator()//instance of Core Image’s QR code generator filter.
    
    @State private var qrCode = UIImage()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter name", text: $name)
                    .textContentType(.name)
                    .font(.title2)
                
                TextField("Ente email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title2)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let image = generateQRCode(text: "\(name)\n\(emailAddress)")
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: image)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
                
            }
            .navigationTitle("Scan QR")
            .onAppear(perform: updateCode) //when view shows, make the qrCode.
            .onChange(of: name) {_ in updateCode() } //when name or email changes, update the qrCode and do not update when the view body updates.
            .onChange(of: emailAddress) { _ in updateCode() }
        }
    }
    
    //Core Image filters requires us to provide some input data, then convert the output CIImage into a CGImage, then that CGImage into a UIImage.
    
    func generateQRCode(text: String) -> UIImage {
        filter.message = Data(text.utf8)  //Our input for the filter will be a string, but the input for the filter is Data, so we need to convert that.
        
        if let outPutimage = filter.outputImage { //read the image from our filter.
            if let cgImage = context.createCGImage(outPutimage, from: outPutimage.extent) {
                return UIImage(cgImage: cgImage) //return UIimage
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(text: "\(name)\n\(emailAddress)")
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
//
//import SwiftUI
//import CoreImage.CIFilterBuiltins
//
//struct MeView: View {
//    
//    @State private var name = "Anonymous"
//    @State private var emailAddress = "you@yoursite.com"
//    
//    // properties to store an active Core Image context
//    // and instance of Core Image's QR code generator
//    let context = CIContext()
//    let filter = CIFilter.qrCodeGenerator()
//    
//    func generateQRCode(from string: String) -> UIImage {
//        // input is a string, convert it to Data
//        let data = Data(string.utf8)
//        filter.setValue(data, forKey: "inputMessage")
//        
//        // if conversion fails, send back SF symbol X mark
//        if let outputImage = filter.outputImage {
//            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgimg)
//            }
//        }
//        // else return an empty UIImage
//        return UIImage(systemName: "xmark.circle") ?? UIImage()
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Name", text: $name)
//                    //  .textContentType tells iOS what kind of information we’re asking the user for
//                    // allow iOS to provide autocomplete data on behalf of the user
//                    .textContentType(.name)
//                    .font(.title)
//                    .padding(.horizontal)
//                
//                TextField("Email address", text: $emailAddress)
//                    .textContentType(.emailAddress)
//                    .font(.title)
//                    .padding([.horizontal, .bottom])
//                
//                // using the name and email address entered by the user, separated by a line break
//                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
//                    // To remove the fuzzy look that isc aused by SwiftUI trying to smooth out the pixels as we scale it up
//                    .interpolation(.none)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//                
//                Spacer()
//                
//            }
//            .navigationBarTitle("Your code")
//        }
//    }
//}
//
//struct MeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeView()
//    }
//}
