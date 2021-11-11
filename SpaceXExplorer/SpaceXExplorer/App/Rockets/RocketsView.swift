//
//  RocketsView.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI
import ComposableArchitecture

struct RocketsView: View {
    let store: Store<RocketsState, RocketsAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                Group {
                    if viewStore.isLoading {
                        VStack {
                            Spacer()
                            ActivityIndicator(style: .large,
                                              isAnimating: viewStore.binding(
                                                get: { $0.isLoading },
                                                send: RocketsAction.loadingActive))
                            Spacer()
                        }
                    } else {
                        VStack {
                            RocketsList(viewStore)
                        }
                    }
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("Rockets")
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
    }
}

extension RocketsView {
    @ViewBuilder
    private func RocketsList(_ viewStore: ViewStore<RocketsState, RocketsAction>) -> some View {
        ForEachStore(
            store.scope(state: { $0.rockets },
                        action: RocketsAction.rocket(id:action:)),
            content: { rocketStore in
                WithViewStore(rocketStore) { rocketViewStore in
                    NavigationLink(
                        destination: RocketDetailView(store: rocketStore),
                        label: {
                            HStack {
                                Image(systemName: "paperplane.circle")
                                    .font(Font.system(.largeTitle))
                                VStack(alignment: .leading) {
                                    Text(rocketViewStore.state.rocket.name)
                                        .font(.headline)
                                    Text(rocketViewStore.state.rocket.firstFlight)
                                        .font(.subheadline)
                                }
                            }
                            
                        }
                    )
                }
            }
        )
    }
}

struct RocketsView_Previews: PreviewProvider {
    static var previews: some View {
        RocketsView(
            store: .init(
                initialState: .init(
                    rockets: .init(
                        uniqueElements: [Rocket.mockRocket1, Rocket.mockRocket2].map {
                        RocketDetailState(id: .init(), rocket: $0)
                    })
                ),
                reducer: rocketsReducer,
                environment: .init(
                    rocketsClient: .mockPreview(),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    uuid: UUID.init
                )
            )
        )
    }
}
