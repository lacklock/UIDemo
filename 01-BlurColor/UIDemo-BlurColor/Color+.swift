//
//  Color+.swift
//  WorkerWidgets (iOS)
//
//  Created by 卓同学 on 2022/5/10.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
    
    public init(
           cube256 colorSpace: RGBColorSpace,
           red: Int,
           green: Int,
           blue: Int,
           opacity: Double = 1.0
       ) {
           self.init(
               colorSpace,
               red: Double(red) / 255.0,
               green: Double(green) / 255.0,
               blue: Double(blue) / 255.0,
               opacity: opacity
           )
       }
    
    /// Creates a color from a hexadecimal color code.
       ///
       /// - Parameter hexadecimal: A hexadecimal representation of the color.
       ///
       /// - Returns: A `Color` from the given color code. Returns `nil` if the code is invalid.
       public init!(hexadecimal string: String) {
           var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           
           if string.hasPrefix("#") {
               _ = string.removeFirst()
           }
           
           if !string.count.isMultiple(of: 2), let last = string.last {
               string.append(last)
           }
           
           if string.count > 8 {
               string = String(string.prefix(8))
           }
           
           let scanner = Scanner(string: string)
           
           var color: UInt64 = 0
           
           scanner.scanHexInt64(&color)
           
           if string.count == 2 {
               let mask = 0xFF
               
               let g = Int(color) & mask
               
               let gray = Double(g) / 255.0
               
               self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
           } else if string.count == 4 {
               let mask = 0x00FF
               
               let g = Int(color >> 8) & mask
               let a = Int(color) & mask
               
               let gray = Double(g) / 255.0
               let alpha = Double(a) / 255.0
               
               self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
           } else if string.count == 6 {
               let mask = 0x0000FF
               
               let r = Int(color >> 16) & mask
               let g = Int(color >> 8) & mask
               let b = Int(color) & mask
               
               let red = Double(r) / 255.0
               let green = Double(g) / 255.0
               let blue = Double(b) / 255.0
               
               self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
           } else if string.count == 8 {
               let mask = 0x000000FF
               
               let r = Int(color >> 24) & mask
               let g = Int(color >> 16) & mask
               let b = Int(color >> 8) & mask
               let a = Int(color) & mask
               
               let red = Double(r) / 255.0
               let green = Double(g) / 255.0
               let blue = Double(b) / 255.0
               let alpha = Double(a) / 255.0
               
               self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
           } else {
               return nil
           }
       }
       
       /// Creates a color from a 6-digit hexadecimal color code.
       public init(hexadecimal6: Int) {
           let red = Double((hexadecimal6 & 0xFF0000) >> 16) / 255.0
           let green = Double((hexadecimal6 & 0x00FF00) >> 8) / 255.0
           let blue = Double(hexadecimal6 & 0x0000FF) / 255.0
           
           self.init(red: red, green: green, blue: blue)
       }
    
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
    #if canImport(UIKit)
        typealias NativeColor = UIColor
    #elseif canImport(AppKit)
        typealias NativeColor = NSColor
    #endif
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }
        
        return (r, g, b, o)
    }
}
