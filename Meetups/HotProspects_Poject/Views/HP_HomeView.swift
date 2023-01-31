//
//  HP_HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/01/2023.
//

import SwiftUI

struct HP_HomeView: View {
    //we need to post that property into the SwiftUI environment, so that all child views can access it.
    @StateObject var propects = Prospects_VM()
    var body: some View {
        TabView {
            ProspectsView(filterType: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filterType: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filterType: .nonContacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        // allow all the child views to access prospects var
        .environmentObject(propects)//When you use @EnvironmentObject you are explicitly telling SwiftUI that your object will exist in the environment by the time the view is created. If it isn’t present, your app will crash immediately 
    }
}

struct HP_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HP_HomeView()
    }
}
