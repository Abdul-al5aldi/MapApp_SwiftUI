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
            Map(initialPosition:  MapCameraPosition.region(vm.mapRegion))
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
