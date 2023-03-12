//
//  StartAssignment.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import SwiftUI

struct StartAssignment: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let text = "Welcome to iOS Cognity Assignment.Push the green button below to Start.Enjoy!!"
    @State private var go = false
    var body: some View {
        VStack {
            NavigationView {
                Image("background").edgesIgnoringSafeArea(.all).overlay {
                    VStack{
                        Image("cognity")
                    }.frame(minWidth: 0, maxHeight: UIScreen.main.bounds.height - 100, alignment: .topLeading)
                    VStack {
                        Text(text)
                    }
                    .fixedSize()
                    .frame(width: 300, alignment: go ? .trailing : .leading)
                    .clipped()
                    .onAppear { self.go.toggle() }
                    .animation(Animation.linear(duration: 9).repeatForever(autoreverses: true), value: go)
                

                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Start Assignment")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 40)
                            .background(Color.green)
                            .cornerRadius(15)
                            .padding()
                    }.frame(minWidth: 0, maxHeight: UIScreen.main.bounds.height - 50, alignment: .bottomLeading)
                    
                }
                
            }.frame(minWidth: 0, maxHeight: UIScreen.main.bounds.height - 50, alignment: .bottomLeading)
        }
            
    }
}
struct StartAssignment_Previews: PreviewProvider {
    static var previews: some View {
        StartAssignment()
    }
}
