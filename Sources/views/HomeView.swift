//
//  ContentView.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import SwiftUI
import SwiftData
let k_WeekMacDistance : Int = 1
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var weekAgo = 0
    @State var maxWeekAgo = 3

    @EnvironmentObject private var  store : Store

  //  @Query private var items: [WorkoutData]

    var body: some View {
        NavigationView {
            TabView(selection: $weekAgo){
                ForEach(0...maxWeekAgo,id: \.self){ idx in
                    WeeklyView(weekAgo: idx).tag(idx)
                }
            }.tabViewStyle(.page)
                .navigationBarTitle(title)
                .navigationBarTitleDisplayMode(.large)
                .toolbar{
                        Button(action: {
                            withAnimation {
                                self.weekAgo = 0
                            }
                        }, label: {
                            Text("Today")
                        }).opacity(weekAgo != 0 ? 1 : 0)
                }
        }.onChange(of: weekAgo) { oldValue, newValue in
            let diff = maxWeekAgo - weekAgo
            if diff < k_WeekMacDistance {
                maxWeekAgo = 2 + maxWeekAgo
            }
        }
    }
    var title : String {
        if weekAgo == 0{
            return "This Week"
            
        } else if  weekAgo == 1 {
            return "Last Week"
            
        } else {
            return "\(self.weekAgo) Weeks Ago"
        }
    }
}

#Preview {
    HomeView()
        //.modelContainer(for: WorkoutData.self, inMemory: true)
}
