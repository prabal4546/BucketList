//
//  MapView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 03/12/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    var annotations:[MKPointAnnotation]
    @Binding var centerCoordinate:CLLocationCoordinate2D
    

    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count{
            view.removeAnnotation(view.annotations as! MKAnnotation)
            view.addAnnotations(annotations)

        }
    }
    func makeCoordinator()-> Coordinator{
        return Coordinator(self)
    }


    class Coordinator: NSObject,MKMapViewDelegate {
        var parent:MapView
        
        init(_ parent:MapView) {
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
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
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(annotations: [MKPointAnnotation.example], centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
//    }
//}

