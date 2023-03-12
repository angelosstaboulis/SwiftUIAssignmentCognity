//
//  CellRow.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import SwiftUI
import SDWebImageSwiftUI
struct CellRow: View {
    @State var show:SHOWModel
    var body: some View {
        ZStack{
            VStack{
                WebImage(url: URL(string:show.thumbnail!))
                Text(show.name!)
                Text(show.rating!)
            }
            NavigationLink {
                DetailsView(details: show)
            } label: {
               EmptyView()
            }.opacity(0).buttonStyle(.plain)
        }
    }
}

struct CellRow_Previews: PreviewProvider {
    static var previews: some View {
        CellRow(show: SHOWModel(name: "", rating: "", thumbnail: ""))
    }
}
