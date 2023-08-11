////
////  EventsListView.swift
////  Owori
////
////  Created by 신예진 on 8/11/23.
////
//
//import SwiftUI
//
//struct EventsListView: View {
//    @EnvironmentObject var myEvents: EventStore
//    @State private var formType: EventFormType?
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(myEvents.events.sorted {$0.date < $1.date }) { event in
//                    ListViewRow(event: event, formType: $formType)
//                    .swipeActions {
//                        Button(role: .destructive) {
//                            myEvents.delete(event)
//                        } label: {
//                            Image(systemName: "trash")
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Calendar Events")
//            .sheet(item: $formType) { $0 }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        formType = .new
//                    } label: {
//                        Image(systemName: "plus.circle.fill")
//                            .imageScale(.medium)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct EventsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsListView()
//            .environmentObject(EventStore(preview: true))
//    }
//}
