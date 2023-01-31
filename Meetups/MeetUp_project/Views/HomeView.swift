//
//  HomeView.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeview_vm = HomeView_VM()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(homeview_vm.meetups.sorted(), id: \.id) { meetUp in
                        NavigationLink {
                            MeetUp_DetailView(meetUp: meetUp) { meetUp_to_delete in
                                homeview_vm.deleteMeetUp(meetUp_to_delete)
                            }
                        } label: {
                            HStack {
                                meetUp.wrappedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 52, height: 52)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.cyan, lineWidth: 2))
                                
                                Text(meetUp.name)
                            }
                        }

                    }
                }
            }
            .navigationTitle("MeetUps")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        homeview_vm.showingMeetup_addView = true
                    } label: {
                        Image(systemName: "plus")
                    }.foregroundColor(.black)

                }
            }
            .sheet(isPresented: $homeview_vm.showingMeetup_addView) {
                Meetup_addView { meetUp in  //take the meetUp from the addView and send to vm to append. So, that passes the meetUp into EditView, and also passes in a closure to run when the Save button is pressed.
                    homeview_vm.addMeetup(meetUp)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
