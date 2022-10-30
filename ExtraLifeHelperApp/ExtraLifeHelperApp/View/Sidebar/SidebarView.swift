//
//  SidebarView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/19/22.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack {
            Image("extra-life-logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 230)

            CSVUploadView()

            Spacer(minLength: 50)
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
