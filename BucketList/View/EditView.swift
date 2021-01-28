//
//  EditView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 28/01/21.
//

import SwiftUI
import MapKit
struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark:MKPointAnnotation
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
            }
            .navigationBarTitle(Text("Edit Place"))
            .navigationBarItems(trailing: Button("Done"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView( placemark: MKPointAnnotation.example)
    }
}