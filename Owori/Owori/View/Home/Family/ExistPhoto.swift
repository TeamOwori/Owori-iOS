//
//  ExistPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct ExistPhoto: View {
    @State var imageName: String = "TestImage1"
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle(Text(imageName), displayMode: .inline)
    }
}

struct ExistPhoto_Previews: PreviewProvider {
    static var previews: some View {
        ExistPhoto()
    }
}
