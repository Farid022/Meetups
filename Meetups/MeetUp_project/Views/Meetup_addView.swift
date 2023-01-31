//
//  Meetup_editView.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import SwiftUI

struct Meetup_addView: View {
    @StateObject private var vm = MeetUp_addview_VM()
    @Environment(\.dismiss) var dismiss
    var onSave: (MeetUp) -> Void //Explained below
    /*
     Problem: when we’re done editing the MeetUp, how can we pass the new MeetUp data back?
     1. Can we use binding -> No, we have optionals, so we want EditView to be bound to a real value rather than an optional value, because otherwise it would get confusing.
     2. we require a function to call where we can pass back whatever new location we want. This means any other SwiftUI can send us some data, and get back some new data to process however we want.
     3. That asks for a function that accepts a single location and returns nothing, which is perfect for our usage. We need to accept that in our initializer, like this:
     4. escaping is needed. it might not called immediatly
     */
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if vm.image == nil {
                        Button {
                            vm.showingPhotoSelection = true
                        } label: {
                            Label("Select Image", systemImage: "photo.on.rectangle.angled")
                        }.foregroundColor(.cyan)
                    } else {
                        vm.image?
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding()
                
                VStack {
                    //we have a second problem: when we’re done editing the location, how can we pass the new location data back?
                    TextField("Enter name", text: $vm.name)
                    TextField("Enter Description", text: $vm.note)
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                
                
                Spacer()
                Button {
                    //we need to update the Save button to create a new meetUp with the modified details, and send it back with onSave()
                    if let newMeetUp = vm.addMeetUp() {
                        onSave(newMeetUp)
                        dismiss()
                    }
                } label: {
                    Label("Save MeetUp", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .disabled(vm.image == nil || vm.name.isEmpty)
                
                Spacer()

            }
            .navigationTitle("Add New MeetUp")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let newMeetUp = vm.addMeetUp() {
                            onSave(newMeetUp)
                            dismiss()
                        }
                    }
                }
            }
            .confirmationDialog("Select source", isPresented: $vm.showingPhotoSelection) {
                Button {
                    vm.showingPhotoLibrary = true
                } label: {
                    Label("Photo Library", systemImage: "photo")
                }
                Button {
                    vm.showingCamera = true
                } label: {
                    Label("Camera", systemImage: "camera")
                }.disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
            }
            .sheet(isPresented: $vm.showingPhotoLibrary) {
                ImagePicker(image: $vm.inputImage)
            }
            .sheet(isPresented: $vm.showingCamera) {
                ImagePicker(image: $vm.inputImage, sourceType: .camera)
            }
            .onChange(of: vm.inputImage) { _ in loadImage() }
        }
    }
    
    func loadImage() {
        guard let inputImage = vm.inputImage else { return }
        vm.image = Image(uiImage: inputImage)
    }
    init(onSave: @escaping (MeetUp) -> Void) {
        self.onSave = onSave
//        _viewModel = StateObject(wrappedValue: ViewModel(memory: memory))
    }
}

//struct Meetup_addView_Previews: PreviewProvider {
//    static var previews: some View {
//        Meetup_addView()
//    }
//}
