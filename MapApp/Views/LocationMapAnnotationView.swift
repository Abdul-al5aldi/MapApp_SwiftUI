//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Abdulrahman AlKhaldi on 31/10/2024.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
//    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack (spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(.accent)
                .clipShape(.rect(cornerRadius: 36))
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
//        .background(.blue)
    }
}

#Preview {
    LocationMapAnnotationView()
}
