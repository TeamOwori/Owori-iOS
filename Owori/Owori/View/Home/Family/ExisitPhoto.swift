//
//  ExisitPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct ExisitPhoto: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle(Text(imageName), displayMode: .inline)
    }
}

//struct ExisitPhoto_Previews: PreviewProvider {
//    static var previews: some View {
//        ExisitPhoto()
//    }
//}
