//
//  MeetUp_DetailView.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import SwiftUI
import MapKit

struct MeetUp_DetailView: View {
    @StateObject var vm: MeetUp_Detail_VM
    @Environment(\.dismiss) var dismiss
    var onDelete: (MeetUp) -> Void
    
    var body: some View {
        VStack {
            Picker("Current View", selection: $vm.currentVisibleView) {
                Image(systemName: "photo")
                    .tag(MeetUp_Detail_VM.VisibleView.photo)
                
                Image(systemName: "map")
                    .tag(MeetUp_Detail_VM.VisibleView.map)
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            
            if vm.currentVisibleView == .photo {
                vm.meetUp.wrappedImage
                    .resizable()
                    .scaledToFit()
            } else if vm.currentVisibleView == .map {
                ZStack {
                    Map(coordinateRegion: $vm.mapRegion, annotationItems: [vm.pin]) { pin in
                        //MapMarker(coordinate: pin.cooredinate)
                        MapAnnotation(coordinate: pin.cooredinate) {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .font(.title)
                        }
                    }
                }
                //.frame(maxWidth: .infinity, maxHeight: 300)
            }
            
            Text(vm.meetUp.name)
                .padding()
            
            Spacer()
        }
        .alert("Delete MeetUp", isPresented: $vm.showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteMeetUp)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete '\(vm.meetUp.name)'?")
        }
        .navigationTitle(vm.meetUp.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                vm.showingDeleteAlert = true
            } label: {
                Label("Delete this meetUp", systemImage: "trash")
                    .foregroundColor(.cyan)
            }
        }
    }
    
    func deleteMeetUp() {
        onDelete(vm.meetUp)
        dismiss()
    }
    
    init(meetUp: MeetUp, onDelete: @escaping (MeetUp) -> Void) {
        self.onDelete = onDelete
        _vm = StateObject(wrappedValue: MeetUp_Detail_VM(meetUp: meetUp))
    }
}

//struct MeetUp_DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetUp_DetailView()
//    }
//}
