//
//  UserView.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: .init(colors: [.indigo, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("User view")
                }
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
