//
//  ContentView.swift
//  CreateHangoutDemo
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TripEntryView(tripService: PreviewTripCreationService())
        }
    }
}

#Preview {
    ContentView()
}
