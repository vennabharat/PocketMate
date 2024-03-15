//
//  ContentView.swift
//  PocketMate
//
//  Created by bharat venna on 06/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showExpenses = true
    @State private var showIncome = false
    @State private var showStatistics = false
    @State private var showUser = false
    
    var body: some View {
        NavigationView {
            ZStack {

                VStack {

                    VStack {

                        if showExpenses && !showIncome && !showStatistics && !showUser {
                            ExpensesView()
                        } else if !showExpenses && showIncome && !showStatistics && !showUser {
                            IncomeView()
                        }else if !showExpenses && !showIncome && showStatistics && !showUser {
                            StatisticsView()
                        }else if !showExpenses && !showIncome && !showStatistics && showUser {
                            UserView()
                        }
                    }

                    Spacer()

                    HStack {

                        Button {

                            showExpenses = true
                            showIncome = false
                            showStatistics = false
                            showUser = false

                        } label: {

                            Image(systemName: "arrow.down.to.line.circle.fill")
                                .font(.system(size: showExpenses ? 60 : 50))
                                .foregroundColor(showExpenses ? .white : .gray)
                                .frame(width: 90, height: 80)
                        }

                        Spacer()

                        Button {

                            showExpenses = false
                            showIncome = true
                            showStatistics = false
                            showUser = false

                        } label: {

                            Image(systemName: "arrow.up.to.line.circle.fill")
                                .font(.system(size: showIncome ? 60 : 50))
                                .foregroundColor(showIncome ? .white : .gray)
                                .frame(width: 90, height: 80)
                        }

                        Spacer()

                        Button {

                            showExpenses = false
                            showIncome = false
                            showStatistics = true
                            showUser = false

                        } label: {

                            Image(systemName: "waveform.circle.fill")
                                .font(.system(size: showStatistics ? 60 : 50))
                                .foregroundColor(showStatistics ? .white : .gray)
                                .frame(width: 90, height: 80)
                        }

                        Spacer()

                        Button {

                            showExpenses = false
                            showIncome = false
                            showStatistics = false
                            showUser = true

                        } label: {

                            Image(systemName: "person.circle.fill")
                                .font(.system(size: showUser ? 60 : 50))
                                .foregroundColor(showUser ? .white : .gray)
                                .frame(width: 90, height: 80)
                        }

                    }
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
