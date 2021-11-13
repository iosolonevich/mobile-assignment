//
//  RocketDetailView.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI
import ComposableArchitecture
import simd

struct RocketDetailView: View {
    let store: Store<RocketDetailState, RocketDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: viewStore.rocket.flickrImages.count) {
                        ForEach(viewStore.rocket.flickrImages, id: \.self) { link in
                            AsyncImage(url: URL(string: link)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .clipped()
                                    
                            } placeholder: {
                                Image(systemName: "photo")
                                    .imageScale(.large)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .frame(height: 250)
    //            .edgesIgnoringSafeArea(.top)
                
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
            
            .navigationBarTitle(viewStore.rocket.name, displayMode: .inline)
        }
    }
}

struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content
    
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common)
        .autoconnect()
    
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring(), value: self.currentIndex)
                .onReceive(self.timer) { _ in
                    self.currentIndex = (self.currentIndex + 1) % numberOfImages
                }
                .gesture(DragGesture().onChanged { value in
                    self.slideGesture = value.translation
                }
                .onEnded { value in
                    if self.slideGesture.width < -50 {
                        if self.currentIndex < self.numberOfImages - 1 {
                            withAnimation {
                                self.currentIndex += 1
                            }
                        }
                    }
                    if self.slideGesture.width > 50 {
                        if self.currentIndex > 0 {
                            withAnimation {
                                self.currentIndex -= 1
                            }
                        }
                    }
                    self.slideGesture = .zero
                })

                HStack(spacing: 3) {
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        Circle()
                            .frame(
                                width: index == self.currentIndex ? 10 : 8,
                                height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.accentColor : Color(.systemGray5))
                            .padding(.bottom, 8)
                            .animation(.spring(), value: self.currentIndex)
                    }
                }
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
