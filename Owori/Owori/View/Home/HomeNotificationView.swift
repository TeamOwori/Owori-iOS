//
//  HomeNotificationView.swift
//  Owori
//
//  Created by 신예진 on 8/7/23.
//

import SwiftUI

struct HomeNotificationView: View {
    
    @State private var isHomeNotificationViewActive = false
    
    var body: some View {
        
        VStack{
            
            Button{
                isHomeNotificationViewActive = true
                
            }label: {
                ZStack {
                    
                }
            }
            .navigationDestination(isPresented: $isHomeNotificationViewActive) {
                
            }
            
            
            
            
        }
    }
}

struct HomeNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNotificationView()
    }
}
