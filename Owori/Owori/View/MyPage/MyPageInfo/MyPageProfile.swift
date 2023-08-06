//
//  MyPageProfile.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct MyPageProfile: View {
         
    var body: some View {
        
        VStack{
            
            Image("background(1)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            MyPageProfilePhoto().offset(y: -60)
            
            VStack(alignment: .leading, spacing: 40) {
                
                VStack(alignment: .leading, spacing: 16)  {
                    
                   MyPageProfileInfo()
                    
                    HStack{
                        MyPageStoryInfo()
                    }
                    
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(0)
            .frame(width: 298, alignment: .leading)
        
            Spacer()
            
        }
    }
}



struct MyPageProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfile()
    }
}
