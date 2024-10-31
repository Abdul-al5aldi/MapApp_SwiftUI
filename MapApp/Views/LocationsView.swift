//
//  LocationsView.swift
//  MapApp
//
//  Created by Abdulrahman AlKhaldi on 31/10/2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    //    @State private var mapRegion: MapCameraPosition = MapCameraPosition.region(vm.mapRegion)
    
    var body: some View {
        
        ZStack {
            Map(position: $vm.mapCameraPos)
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                header
                    .padding()
                
                
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color: .black.opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    
    private var header: some View {
        
        VStack {
            Button(action: {vm.toggleLocationsList()}, label: {
                
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(Color.primary)
                    .frame(height: 55)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                            .padding()
                            .rotationEffect(Angle(
                                degrees: vm.showLocationsList ? 180 : 0))
                    }
                
            })
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
}
