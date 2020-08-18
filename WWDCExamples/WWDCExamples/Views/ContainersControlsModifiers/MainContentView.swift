//
//  MainContentView.swift
//  Quidco
//
//  Created by George Quentin Ngounou on 22/07/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

// 17) 

struct MainContentView: View {
    @ObservedObject var viewModel = ActivitiesViewModel() // 13) you use ObservedObject when you have a custom type you want to use that might have multiple properties and methods, or might be shared across multiple views – This used to be called BindableObject.
    var body: some View {
        NavigationView { // 5) embed a navigation bar
            
            List {
                Button(action: addNewActivity) { // 14) crud: create new item in list
                    Text("add_activity")// 16) localizable strings do not need to conform with NSLocalizedString anymore, swiftUI automatically infers which strings are localizable or not
                }
                ForEach(viewModel.activities) { item in
                    ActivityCell(activity: item)
                }
                .onDelete(perform: deleteActivities) // 14) crud: delete item in list
                .onMove(perform: moveActivity) // 14) crud: update or edit item in List
            
            }
            .navigationBarTitle(Text("activities_title"))
            .navigationBarItems(trailing: EditButton())
            .listStyle(GroupedListStyle())
            
        }
    }
    
    func addNewActivity() {
        self.viewModel.activities.append(SwiftUIActivity(title: "My new Item", subtitle: "5 people", publisher: "Apple", year: 2020, url: "https://www.geo-games.com", imageName: "apple"))
    }
    
    func deleteActivities(for offset: IndexSet) {
        self.viewModel.activities.remove(atOffsets: offset)
    }
    
    func moveActivity(from source: IndexSet, to destination: Int) {
        self.viewModel.activities.move(fromOffsets: source, toOffset: destination)
    }
}

struct MainContentView_Previews: PreviewProvider {

    static var previews: some View {
        // 15) You can preview multiple versions of your view using Group
        Group {
            MainContentView(viewModel: ActivitiesViewModel(activities: mockData))
            MainContentView(viewModel: ActivitiesViewModel(activities: mockData))
                .environment(\.sizeCategory, .extraExtraExtraLarge) // 15) then change the preview environment to use something like a sizeCategory, that makes a view much larger in size. the environment is a way to set contextual information about your views that flows down the view heirachy and changes different aspects of any contained views all at once, its great for having large set of views and its great for customising previews. to see your view in different context like Dark Mode
            MainContentView(viewModel: ActivitiesViewModel(activities: mockData))
                .environment(\.colorScheme, .dark)
            MainContentView(viewModel: ActivitiesViewModel(activities: mockData))
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

struct ActivityCell: View {
    let activity: SwiftUIActivity
    var destination: some View {
        switch activity.type {
        case .tutorial:
            return AnyView(ActivityDetailView(activity: activity))
        case .toast:
            return AnyView(AvocadoToastView(orders: mockOrdersData))
        case .dataFlow:
            return AnyView(
                MusicPlayerView().environmentObject(
                    PodcastPlayerStore(episode:
                        Episode(title: "Fireside Chat with Geo", showTitle: "About Crowdfunding"))))
        case .customViews:
            return AnyView(
                CircleView().environmentObject(Ring(wedges: [
                    0: Ring.Wedge(startAngle: Angle(radians: 0), width: 0.3, depth: 0.5, hue: 0),
                    1: Ring.Wedge(startAngle: Angle(radians: 1), width: 0.1, depth: 1, hue: 0.1),
                    2: Ring.Wedge(startAngle: Angle(radians: 2), width: 0.3, depth: 0.2, hue: 0.5),
                    3: Ring.Wedge(startAngle: Angle(radians: 3), width: 0.2, depth: 0.8, hue: 0.9)
                    ])
                )
            )
        case .userSettings:
            return AnyView(UserList())
        }
    }
    
    var body: some View {
        NavigationLink(destination: destination) {//6) add a button to each cell and present a next screen
            Image(activity.imageName)
                .resizable()
                .frame(width: 64.0, height: 64.0) // 8) resize image by frame but must user resizable before using the frame modifier
                .cornerRadius(10.0)
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.title)
                    .fontWeight(.semibold)
                Text(activity.subtitle)
                    .font(.subheadline) // 3) methods like these are call modifyiers and they are used in swiftUI to modify the way your views look or behave. you can view the modifiers that are available in the modifiers library
                    .foregroundColor(Color.secondary)
                Text(String(describing: activity.year))
                    .font(.caption)
                
            }
        }
    }
}
