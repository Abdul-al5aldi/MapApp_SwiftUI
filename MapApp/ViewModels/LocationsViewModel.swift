//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Abdulrahman AlKhaldi on 31/10/2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
            print("in didSet")
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var mapCameraPos: MapCameraPosition = MapCameraPosition.automatic
    
    
    // Show list of location
    @Published var showLocationsList: Bool = false
    
    // Show location details via Sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
            print("in updateMapRegion")
            mapCameraPos =  MapCameraPosition.region(mapRegion)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
            print("in showNextLocation")
        }
    }
    
    func nextButtonPressed() {
        
        // Get current location's index
        guard let currentIndex = locations.firstIndex(where: { location in
            return location == mapLocation
        }) else {
            print("Could not find current index in location array!")
            return
        }
        
        // Check if nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // nextIndex is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else {
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        // nextIndex is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
    
}
