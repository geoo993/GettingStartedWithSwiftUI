//
//  SwiftUIActivities.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 27/07/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//
// https://developer.apple.com/videos/play/wwdc2019/238
// https://medium.com/better-programming/understanding-swiftui-data-flow-79429a49ae35
// https://medium.com/swlh/clean-architecture-for-swiftui-6d6c4eb1cf6a
// https://medium.com/better-programming/the-complete-swiftui-documentation-youve-been-waiting-for-fdfe7241add9
// https://medium.com/flawless-app-stories/mvvm-in-swiftui-8a2e9cc2964a
// https://medium.com/better-programming/whats-new-in-swiftui-2-0-ed13f2c40ae2
// https://www.hackingwithswift.com/quick-start/swiftui/swiftui-tips-and-tricks
// https://developer.apple.com/videos/play/wwdc2020/10119
// https://developer.apple.com/videos/play/wwdc2020/10041
// https://developer.apple.com/tutorials/swiftui/creating-and-combining-views

import SwiftUI

enum SwiftUIAppType: Equatable, Hashable {
    case tutorial
    case toast
    case dataFlow
    case customViews
    case userSettings
}

// 4) to use this model in SwiftUI, we just need to make this struct conform to Identifiable so that our list in swiftUI can know about it
struct SwiftUIActivity: Identifiable {
    var id = UUID()
    var type: SwiftUIAppType = .tutorial
    var title: String
    var subtitle: String
    var publisher: String
    var year: Int
    var url: String
    var imageName: String
}

let mockData: [SwiftUIActivity] = [
    SwiftUIActivity(title: "Introducing SwiftUI", subtitle: "Building Your First App", publisher: "Apple", year: 2019, url: "https://developer.apple.com/videos/play/wwdc2019/204", imageName: "apple"),
    SwiftUIActivity(type: .toast, title: "SwiftUI Essentials", subtitle: "", publisher: "Apple", year: 2019, url: "https://developer.apple.com/videos/play/wwdc2019/216", imageName: "apple"),
    SwiftUIActivity(type: .dataFlow, title: "Data Flow Through SwiftUI", subtitle: "", publisher: "Apple", year: 2019, url: "https://developer.apple.com/videos/play/wwdc2019/226", imageName: "apple"),
    SwiftUIActivity(type: .customViews, title: "Building Custom Views with SwiftUI", subtitle: "", publisher: "Apple", year: 2019, url: "https://developer.apple.com/videos/play/wwdc2019/237", imageName: "apple"),
    SwiftUIActivity(type: .userSettings, title: "SwiftUI tips and tricks", subtitle: "", publisher: "Apple", year: 2019, url: "https://www.hackingwithswift.com/quick-start/swiftui/swiftui-tips-and-tricks", imageName: "apple"),
    SwiftUIActivity(title: "Introduction to SwiftUI", subtitle: "", publisher: "Apple", year: 2020, url: "https://developer.apple.com/videos/play/wwdc2020/10119", imageName: "apple"),
    SwiftUIActivity(title: "What's new in SwiftUI", subtitle: "", publisher: "Apple", year: 2020, url: "https://developer.apple.com/videos/play/wwdc2020/10041", imageName: "apple")
]

// SwiftUI and Combine are two new frameworks that were announced at WWDC 2019. SwiftUI was introduced as a revolutionary, new way to build better apps, faster.
// Combine is described as a unified declarative framework for processing values over time
class ActivitiesViewModel: ObservableObject { // 13) The ObservableObject (formerlly known as BindableOject) basically allow us to observe changes from our model when used inside a view. so conformance to this allows instances of this class to be used inside views, so that when important changes happen the view will reload.
    @Published var activities: [SwiftUIActivity] // 14) The @Published property wrapper tells SwiftUI that changes to activities should trigger view reloads.
    
    init(activities: [SwiftUIActivity] = []) {
        self.activities = activities
        fetchActivities()
    }
    
    func fetchActivities() {
        
    }
    
}
