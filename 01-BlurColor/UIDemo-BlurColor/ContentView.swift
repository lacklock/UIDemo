//
//  ContentView.swift
//  UIDemo-BlurColor
//
//  Created by 卓同学 on 2024/6/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(hexadecimal: "#0C0E13")
                .ignoresSafeArea()
            VStack(spacing: 30)  {
                HStack(spacing: 30) {
                    //整体模糊
                    Circle()
                        .fill(Color(hexadecimal: "#ba762f"))
                        .blur(radius: 20) //调整模糊半径
                        .frame(width: 120)
                    
                    //径像渐变模糊
                    Circle()
                        .fill(radialGradient)
                        .blur(radius: 10)
                        .frame(width: 120, height: 120)
                }
                
                //叠加渐变
                ZStack{
                    Circle()
                        .fill(Color(hexadecimal: "#78ffd6"))
                        .blur(radius: 20)
                        .frame(width: 140)
                    Circle()
                        .fill(Color(hexadecimal: "#a8ff78"))
                        .blur(radius: 20)
                        .frame(width: 80)
                        .offset(x: -10)
                }
                .frame(width: 170, height: 170)
            }
        }
    }
    
    // 径像渐变色
    private var radialGradient: RadialGradient {
       return RadialGradient(colors: [Color(hexadecimal: "#a8ff78"), Color(hexadecimal: "#78ffd6")],
                                 center: UnitPoint(x: 0.50, y: 0.50),
                                 startRadius: 10.00,
                                 endRadius: 60.00)
    }
}

#Preview {
    ContentView()
}
