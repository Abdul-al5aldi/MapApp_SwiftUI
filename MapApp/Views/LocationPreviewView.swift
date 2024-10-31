//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Abdulrahman AlKhaldi on 31/10/2024.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        
        HStack (alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }
            VStack (spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 50))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
            .environmentObject(LocationsViewModel())
    }
}



extension LocationPreviewView {
    
    private var imageSection: some View {
        
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(6)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        
    }
    
    
    private var titleSection: some View {
        
        VStack (alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        
    }
    
    private var learnMoreButton: some View {
        
            Button(action: {
                vm.sheetLocation = location
            }, label: {
                Text("Learn more")
                    .font(.headline)
                    .frame(width: 125, height: 35)
            })
            .buttonStyle(.borderedProminent)
        
    }
    
    private var nextButton: some View {
        
        Button(action: {
            vm.nextButtonPressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.bordered)
        
    }
}
