//
//  Prospect.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/01/2023.
//

import SwiftUI
//if class. then it allows us to change instances of the class directly and have it be updated in all other views at the same time
class Prospect: Identifiable, Codable {
    
    let id = UUID()
    var name = "Unknown"
    var emailaddress = ""
    fileprivate(set) var isContected = false //which means “this property can be read from anywhere, but only written from the current file. So it must be in the same file.
}


@MainActor class Prospects_VM: ObservableObject {
    @Published private(set) var people = [Prospect]()
    let saveKey = "SavedData"
    
    
    //Updating the Prospects initializer so that it loads its data from UserDefaults where possible
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//        people = []
//    }
    
    func addPerson(propect: Prospect) {
        people.append(propect)
        //save()
    }
    
    //To fix this, we need to tell SwiftUI by hand that something important has changed. So, rather than flipping a Boolean in ProspectsView, we are instead going to call a method on the Prospects class to flip that same Boolean while also sending a change notification out.
    func toggle_peopeState(prospect: Prospect) {
        objectWillChange.send()
        prospect.isContected.toggle()
        //save()
    }
    
//    private func save() {
//    if let encoded = try? JSONEncoder().encode(people) {
//        UserDefaults.standard.set(encoded, forKey: saveKey)
//    }
//
//
//}
    
    
    
    //Use JSON and document directory for saving and loading data.
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProspects")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
        print("People \(people.count)")
    }
    
    //Save the people data to its local document directory.
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func deleteProspect(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
    
//    func deleteProspect(_ prospect: Prospect) {
//        guard let index = people.firstIndex(of: prospect) else { return }
//        people.remove(at: index)
//        save()
//    }
    
    //
//    @EnvironmentObject var prospects: Prospects
//     @State private var prospectsArray = [Prospect]()
//
//     @State private var isShowingScanner = false
//     @State private var showingActionSheet = false
//     @State private var sortedByName = true
//    func getFilteredAndSortedProspects(_ array: [Prospect]) -> [Prospect] {
//        var array = prospectsArray
//        if sortedByName {
//          array = filteredProspects.sorted { $0.name < $1.name }
//          return array
//        } else {
//          array = filteredProspects.reversed()
//          return array
//        }
//      }
    
    
    //func validateView(_ prospect: Prospect) -> Bool {
//    if prospect.wasContacted == true && filter == .none {
//      return true
//    } else {
//      return false
//    }
//  }
    
    

}
