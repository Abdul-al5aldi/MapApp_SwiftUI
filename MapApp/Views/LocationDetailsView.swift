//
//  LocationDetailsView.swift
//  MapApp
//
//  Created by Abdulrahman AlKhaldi on 01/11/2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack (alignment: .leading, spacing: 16, content: {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                })
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay (alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    LocationDetailsView(location:
                            LocationsDataService.locations.first!)
    .environmentObject(LocationsViewModel())
}


extension LocationDetailsView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack (alignment: .leading, spacing: 8, content: {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        })
    }
    
    
    private var descriptionSection: some View {
        VStack (alignment: .leading, spacing: 16, content: {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        })
    }
    
    
    private var mapLayer: some View {
        
        Map(position: .constant(MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))) {
            Annotation(location.name, coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
                
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 30))
        .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
    }
    
    private var backButton: some View {
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(Color.primary)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 4)
                .padding()
        })
    }
    
}
