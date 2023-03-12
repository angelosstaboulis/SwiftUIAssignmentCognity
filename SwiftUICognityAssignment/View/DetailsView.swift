//
//  DetailsView.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailsView: View {
    @State var details:SHOWModel
    var body: some View {
        VStack{
            WebImage(url: URL(string:details.thumbnail!))
            Text(details.name!)
            Text(details.rating!)
        }.navigationTitle(details.name!)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(details: SHOWModel(name: "", rating: "", thumbnail: ""))
    }
}
