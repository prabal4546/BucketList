//
//  EditView.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 28/01/21.
//

import SwiftUI
import MapKit
struct EditView: View {
    
    enum LoadingState {
        case loading,loaded,failed
    }
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark:MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                Section(header:Text("Nearby...")){
                    if loadingState == .loaded{
                        List(pages, id: \.pageid){page in
                            Text(page.title)
                                .font(.headline)
                            + Text(":") +
                            Text("Page description here")
                                .italic()
                        }
                        else if loadingState = .loading{
                            Text("Loading..")
                        }else{
                            Text("Please check your connection and try again")
                        }
                    }
                    
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
