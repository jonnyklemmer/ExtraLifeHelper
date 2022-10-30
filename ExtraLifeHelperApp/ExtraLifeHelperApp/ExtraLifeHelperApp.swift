//
//  ExtraLifeHelperApp.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/19/22.
//

import SwiftUI

@main
struct ExtraLifeHelperApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }.commands {
            SidebarCommands()
        }
    }
}
