//
//  ContentView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 02/12/20.
//

import SwiftUI

struct ContentView: View {
    

    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
