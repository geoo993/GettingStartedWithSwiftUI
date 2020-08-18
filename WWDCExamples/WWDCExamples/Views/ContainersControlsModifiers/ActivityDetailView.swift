//
//  ActivityDetailView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 27/07/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: SwiftUIActivity
    @State private var zoomed = false // 10) when swiftUI sees a view with a @State variable, it allocates storage for that variable on the views behalf. one of the special properties of State variables is that swiftUI can observe when they are read or written.
    var body: some View {
        ZStack(alignment: .topLeading) { // 12) use a ZStack to show views stacked on top of each other, and it has some great arguements as well like alignment
            Image(activity.imageName) // 8) by default swiftUI presents all images by the size of its contents
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit) // 9) fill will resize the image to fill the frame, fit will make the image fit the frame. swuiftUI is observing changes on the zoomed variable and knows that the view depends on it.
                .navigationBarTitle(Text(activity.title), displayMode: .inline) // 10) you can switch between large title or normal title using NavigationBarTitle DisplayMode to .inline or .large
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.5)) { // 11) in swiftUI animations are really easy to add, you can wrapp any code with the code withAnimationion { ... }
                        self.zoomed.toggle()
                        
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            if !zoomed {
                Button("go_to_page") {
                        if let url = URL(string: self.activity.url) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .font(.body)
                    .padding(.all)
                    .transition(.move(edge: .trailing))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 60, alignment: .trailing)
                    
                Image(systemName: "video.fill")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.all)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityDetailView(activity: mockData[0])
        }
    }
}
