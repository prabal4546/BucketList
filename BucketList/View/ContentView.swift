//
//  ContentView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 02/12/20.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
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
        MapView()
            .edgesIgnoringSafeArea(.all)
        VStack{
            if self.isUnlocked{
                Text("Unlocked")
            }else{
                Text("Locked")
            }
        }
        .onAppear(perform:authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
