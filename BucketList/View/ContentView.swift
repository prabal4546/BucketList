//
//  ContentView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 02/12/20.
//
import MapKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var isUnlocked = false
    
    func authenticate(){
        let context = LAContext()
        var error:NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "we need to securely unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {success, authenticationError in
                DispatchQueue.main.async {
                    if success{
                        //if authenticated successfully
                        self.isUnlocked = true
                        
                    }else{
                        
                    }
                }
            })
        }
        else{
            //their is not authentication at all, like iPod touch
        }
    }

    var body: some View {

        ZStack{
MapView(centerCoordinate: $centerCoordinate)
    .edgesIgnoringSafeArea(.all)
    Circle()
        .fill()
        .opacity(0.3)
        .frame(width: 32, height: 32)
        }
        .onAppear(perform:authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
