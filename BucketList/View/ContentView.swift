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
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var isUnlocked = false
    @State private var selectedPlace:MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    
    
    var body: some View {
        
        ZStack{
                MapView(annotations:locations, centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill()
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack{
                    Spacer()
                    HStack(){
                        Spacer()
                        Button( action:{
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Atlantis"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }){
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
            }
            .alert(isPresented: $showingPlaceDetails){
                Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("Ok")),secondaryButton: .default(Text("Edit")){
                    //edit this place
                    self.showingEditScreen = true
                    
                }
                )
            }
            .sheet(isPresented: $showingEditScreen,onDismiss: saveData){
                if self.selectedPlace != nil{
                    EditView(placemark: self.selectedPlace!)
                }
            }.onAppear(perform:loadData)
        }
    }
    func getDocumentsDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    func saveData() {
        do{
            let fileName = getDocumentsDirectory().appendingPathComponent("savedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
            
        }
        catch{
            print("Unable to save data.")
            
        }
    }
    func authenticate(){
        let context = LAContext()
        var error:NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to securely unlock your data."
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
