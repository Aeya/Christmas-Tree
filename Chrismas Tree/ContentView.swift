//
//  ContentView.swift
//  Chrismas Tree
//
//  Created by Hatairat Kortrakulkij on 25/12/24.
//

import SwiftUI

struct ContentView: View {
   @State private var isLightOn = true
      @State private var isAnimating = false
      
      var body: some View {
          VStack {
              // Merry Christmas Text
              Text("Merry Christmas!")
                  .font(.custom("Chalkboard SE", size: 32))
                  .foregroundColor(isLightOn ? .red : .clear)
                  .shadow(color: .yellow, radius: isLightOn ? 2 : 0)
                  .scaleEffect(isLightOn ? 1.1 : 1.0)
                  .animation(.easeInOut(duration: 1.0), value: isLightOn)
                  .padding(.bottom, 20)
              
              ZStack {
                  // Tree outline in dark green
                  TreeShape()
                      .fill(Color(red: 0.0, green: 0.3, blue: 0.0))
                      .frame(width: 200, height: 300)
                  
                  // Lights layer
                  TreeShape()
                      .fill(
                          isLightOn ?
                          AnyShapeStyle(
                              LinearGradient(
                                  colors: [.red, .green, .yellow, .blue],
                                  startPoint: .top,
                                  endPoint: .bottom
                              )
                          ) : AnyShapeStyle(Color.clear)
                      )
                      .opacity(isAnimating ? 0.8 : 0.4)
                      .frame(width: 200, height: 300)
                      .animation(
                          isLightOn ?
                          Animation.easeInOut(duration: 1.0).repeatForever() :
                          .default,
                          value: isAnimating
                      )
                      .onAppear {
                          isAnimating.toggle()
                      }
                  
                  // Star on top
                  Image(systemName: "star.fill")
                      .foregroundColor(isLightOn ? .yellow : .gray)
                      .font(.system(size: 30))
                      .offset(y: -160)
              }
              
              Button(action: {
                  isLightOn.toggle()
              }) {
                  Text(isLightOn ? "Turn Off Lights" : "Turn On Lights")
                      .foregroundColor(.white)
                      .padding()
                      .background(isLightOn ? Color.red : Color.gray)
                      .cornerRadius(10)
              }
              .padding()
          }
      }
  }

  // TreeShape struct remains the same
  struct TreeShape: Shape {
      func path(in rect: CGRect) -> Path {
          var path = Path()
          
          let width = rect.width
          let height = rect.height
          let triangleHeight = height * 0.25
          
          // Bottom triangle
          path.move(to: CGPoint(x: width * 0.1, y: height * 0.9))
          path.addLine(to: CGPoint(x: width * 0.9, y: height * 0.9))
          path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.5))
          path.addLine(to: CGPoint(x: width * 0.1, y: height * 0.9))
          
          // Middle triangle
          path.move(to: CGPoint(x: width * 0.2, y: height * 0.6))
          path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.6))
          path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.3))
          path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.6))
          
          // Top triangle
          path.move(to: CGPoint(x: width * 0.3, y: height * 0.35))
          path.addLine(to: CGPoint(x: width * 0.7, y: height * 0.35))
          path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.1))
          path.addLine(to: CGPoint(x: width * 0.3, y: height * 0.35))
          
          return path
      }
  }

#Preview {
    ContentView()
}
