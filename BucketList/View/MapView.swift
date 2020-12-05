//
//  MapView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 03/12/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    class Coordinator: NSObject,MKMapViewDelegate {
        var parent:MapView
        init(_ parent:MapView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator()-> Coordinator{
        return Coordinator(self)
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView:MKMapView){
        print(mapView.centerCoordinate)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    // to customise the pin on the map
    func mapView(mapView:MKMapView, viewFor annotation:MKAnnotation)->MKAnnotation?{
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
    

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
