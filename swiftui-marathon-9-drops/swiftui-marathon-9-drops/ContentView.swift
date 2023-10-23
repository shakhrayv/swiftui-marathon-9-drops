//
//  ContentView.swift
//  swiftui-marathon-9-drops
//
//  Created by Vladislav Shakhray on 23/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            GeometryReader(content: { geometry in
                
                Canvas { context, size in
                    let circle1 = context.resolveSymbol(id: 0)!
                    let circle2 = context.resolveSymbol(id: 1)!
                    
                    context.addFilter(.colorInvert())
                    context.addFilter(.alphaThreshold(min: 0.3))
                    context.addFilter(.blur(radius: 20.0))
                    context.drawLayer { innerContext in
                        innerContext.draw(circle1, at: .init(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0))
                        innerContext.draw(circle2, at: .init(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0))
                    }
                    
                } symbols: {
                    Circle()
                        .fill(.white)
                        .frame(width: 100, height: 100, alignment: .center)
                        .tag(0)
                 
                    Circle()
                        .fill(.white)
                        .frame(width: 100, height: 100, alignment: .center)
                        .tag(1)
                        .offset(x: offset.width, y: offset.height)
                    
                }
                .gesture(
                    DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    
                }.onEnded { value in
                    withAnimation(.spring(bounce: 0.4)) {
                        offset = .zero
                    }
                })
            })
        }
    }
}

#Preview {
    ContentView()
}
