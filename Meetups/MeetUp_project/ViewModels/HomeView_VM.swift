//
//  HomeView_VM.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation
import CodeScanner

extension HomeView {
    @MainActor class HomeView_VM: ObservableObject {
        @Published private(set) var meetups = [MeetUp]()
        
        @Published var showingMeetup_addView = false
        
        //path for saving the user data to document directory.
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedMeetups")
        
        //create a new initializer and a new save() method that makes sure our data is saved automatically
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                meetups = try JSONDecoder().decode([MeetUp].self, from: data)
            } catch {
                meetups = []
            }
            print("Meetups \(meetups.count)")
        }
        
        //Save the gymers data to its local document directory
        func save() {
            do {
                let data = try JSONEncoder().encode(meetups)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        //what is going here...
        /*
         Meetup_addView { meetUp in homeview_vm.addMeetup(meetUp) }
         */
        func addMeetup(_ meetUp: MeetUp) {
            meetups.append(meetUp)
            save()
        }
        
        
        
        func deleteMeetUp(_ meetUp: MeetUp) {
            guard let index = meetups.firstIndex(of: meetUp) else { return }
            meetups.remove(at: index)
            save()
        }
        
        
        func updateMemory() { }
    }
}
