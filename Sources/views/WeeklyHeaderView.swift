//
//  WeeklyHeaderView.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import SwiftUI

struct WeeklyHeaderView: View {
    let kCal : Int
    let time : TimeInterval
    let qty : Int
    let date : Date
    
    var body: some View {
        HStack(alignment: .top) {

                VStack(alignment: .leading){
                    Text("Count").foregroundColor(.indigo).bold().font(.title3)
                    Text("\(qty)").bold().font(.title2)
                }
                VStack(alignment: .leading){
                    Text("Time").foregroundColor(.green).bold().font(.title3)
                    Text(time.stringTimeShort).bold().font(.title2)
                }.padding(.horizontal)
                
                
                VStack(alignment: .leading){
                    Text("Move").foregroundColor(.red).bold().font(.title3)
                    HStack(){
                        Text("\(kCal)").bold().font(.title2)
                        Text("kcal").foregroundColor(.gray)
                        
                    }
                }
            }
        Text(date.weekString()).foregroundColor(.gray).font(.callout).bold()
    }
  
}

#Preview {
    WeeklyHeaderView(kCal: 320, time: 1000, qty: 4,date: .now)
}
