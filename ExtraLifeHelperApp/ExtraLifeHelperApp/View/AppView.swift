//
//  AppView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/19/22.
//

import SwiftUI

// TODO: Credit https://github.com/sameersyd/FortuneWheel in readme

struct AppView: View {
    let viewModel = CSVViewModel()

    var body: some View {
        NavigationView {
            SidebarView()
            ContentView(document: .constant(CSVDocument()))
        }
        .environmentObject(viewModel)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }

    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
