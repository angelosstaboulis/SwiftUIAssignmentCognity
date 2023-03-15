//
//  ContentView.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Network
struct ContentView: View {
    @StateObject var helper = Helper()
    @State var onLinelist:[SHOWModel] = []
    @ObservedObject var viewModel = SHOWViewModel()
    var body: some View {
        NavigationView{
            List(self.onLinelist){ show in
                CellRow(show: show)
            }
        }.onAppear {
            DispatchQueue.main.async {
                if helper.isOnline {
                    Task.init{
                        self.onLinelist = await viewModel.fetchTVShows()
                            for item in 0..<self.onLinelist.count{
                                viewModel.insertRecord(dbStruct:DBStruct(id: item, name: self.onLinelist[item].name!, ratings: self.onLinelist[item].rating!, thumb: self.onLinelist[item].thumbnail!))
                                
                            }
                    }
                }else{
                    let shows = Array(viewModel.fetchRecords())
                    debugPrint("shows=",shows.count,shows)
                    for item in 0..<shows.count {
                        self.onLinelist.append(SHOWModel(name: shows[item].name, rating: shows[item].ratings, thumbnail: shows[item].thumb))
                    }
                    
                }
                
            }
        }.navigationBarBackButtonHidden()
    }
}
            
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
