//
//  HealthDataApp.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import SwiftUI
import SwiftData

@main
struct HomeApp: App {
    let store = Store()

    @State var isSetup = false
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            WorkoutData.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    

    var body: some Scene {
        WindowGroup {
            Group{
                if isSetup {
                    HomeView().environmentObject(store)
                } else {
                    Text("Enable Health Access")
                }
            }.onAppear(perform: {
                Task {
                    isSetup = await store.setup()
                }
            })
          
            
        }
        
        //.modelContainer(sharedModelContainer)
        
    }
}
