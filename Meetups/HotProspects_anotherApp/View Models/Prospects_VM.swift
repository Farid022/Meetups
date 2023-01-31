//
//  Prospects_VM.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/01/2023.
//

//import Foundation
//import CodeScanner
//
//@MainActor class Prospects_VM: ObservableObject {
//    @Published var people = [Prospect]()
//    
//    
//    init() {
//        people = []
//    }
//    
//    //To fix this, we need to tell SwiftUI by hand that something important has changed. So, rather than flipping a Boolean in ProspectsView, we are instead going to call a method on the Prospects class to flip that same Boolean while also sending a change notification out.
//    func toggle_peopeState(prospect: Prospect) {
//        objectWillChange.send()
//        prospect.isContected.toggle()
//    }
//
//}
