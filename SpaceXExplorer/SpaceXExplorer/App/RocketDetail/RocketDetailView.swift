//
//  RocketDetailView.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI
import ComposableArchitecture

struct RocketDetailView: View {
    let store: Store<RocketDetailState, RocketDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("Overview")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(viewStore.rocket.rocketDescription)
                        .padding(.bottom, 10)
                    Text("Parameters")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewStore.rocketParameters) { parameter in
                                RocketParameterView(rocketParameter: parameter)
                            }
                        }
                    }.padding(.bottom, 15)
                    
                    
                    ForEach(viewStore.rocketStages.indices) { i in
                        RocketStageView(rocketStage: viewStore.rocketStages[i], index: i)
                    }
                   
                }.padding()
            }
        }
    }
}

struct RocketParameterView: View {
    let rocketParameter: RocketParameter
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(
                cornerRadius: 20)
                .fill(Color.accentColor)
                .frame(width: 100, height: 100)
            
            VStack(spacing: 3) {
                Text(rocketParameter.parameterValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(rocketParameter.parameterName)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        }
    }
}

struct RocketStageView: View {
    let rocketStage: RocketStage
    let index: Int
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("LightGrayColor"))
            
            VStack(alignment: .leading) {
                switch index {
                case 0:
                    Text("First stage")
                        .font(.headline)
                case 1:
                    Text("Second stage")
                        .font(.headline)
                default:
                    Text("Stage")
                        .font(.headline)
                }
                
                HStack {
                    Image("Reusable")
                    Text(rocketStage.isReusable)
                }
                HStack {
                    Image("Engine")
                    Text(rocketStage.enginesCount)
                }
                HStack {
                    Image("Fuel")
                    Text(rocketStage.fuelMassT)
                }
                HStack {
                    Image("Burn")
                    Text(rocketStage.burnTimeSeconds)
                }
            }
            .padding()
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RocketDetailView(
                store: .init(
                    initialState: RocketDetailState(
                        id: .init(),
                        rocket: .mockRocket1
                    ),
                    reducer: rocketDetailReducer,
                    environment: .init(
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                    )
                )
            )
        }
    }
}
