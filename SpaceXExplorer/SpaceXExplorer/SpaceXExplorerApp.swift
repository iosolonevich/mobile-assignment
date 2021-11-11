//
//  SpaceXExplorerApp.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI

@main
struct SpaceXExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: .init(
                    initialState: .init(),
                    reducer: mainReducer,
                    environment: .init(
                        rocketsClient: .live,
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                        uuid: UUID.init
                    )
                )
            )
        }
    }
}
