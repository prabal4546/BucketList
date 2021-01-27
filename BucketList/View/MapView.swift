//
//  MapView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 03/12/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate:CLLocationCoordinate2D
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
    
        return mapView
    }
    func makeCoordinator()-> Coordinator{
        return Coordinator(self)
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView:MKMapView){
        print(mapView.centerCoordinate)
    }
    
 
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    class Coordinator: NSObject,MKMapViewDelegate {
        var parent:MapView
        
        init(_ parent:MapView) {
            self.parent = parent
        }
    }
    

    // to customise the pin on the map
    func mapView(mapView:MKMapView, viewFor annotation:MKAnnotation)->MKAnnotation?{
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view.annotation
    }
    

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
    }
}
extension MKPointAnnotation{
    static var example:MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer olympics"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
