import SwiftUI

@available(iOS 13.0, *)
public extension PreviewDevice {
    static var iPhone7 = PreviewDevice(rawValue: "iPhone 7")
    static var iPhone8 = PreviewDevice(rawValue: "iPhone 8")
    static var iPhone8_Plus = PreviewDevice(rawValue: "iPhone 8 Plus")
    static var iPhone11 = PreviewDevice(rawValue: "iPhone 11")
    static var iPhone11_Pro = PreviewDevice(rawValue: "iPhone 11 Pro")
    static var iPhone11_Pro_Max = PreviewDevice(rawValue: "iPhone 11 Pro Max")
    static var iPhone12 = PreviewDevice(rawValue: "iPhone 12")
    static var iPhone12_Pro = PreviewDevice(rawValue: "iPhone 12 Pro")
    static var iPhone12_Pro_Max = PreviewDevice(rawValue: "iPhone 12 Pro Max")
    static var iPhone12_Mini = PreviewDevice(rawValue: "iPhone 12 mini")
    static var iPhone13 = PreviewDevice(rawValue: "iPhone 13")
    static var iPhoneSE = PreviewDevice(rawValue: "iPhone SE (2nd generation)")
    static var iPad = PreviewDevice(rawValue: "iPad (8th generation)")
    static var iPad_Air = PreviewDevice(rawValue: "iPad Air (4th generation)")
    static var iPad_Pro_11inch = PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)")
    static var iPad_Pro_12inch = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (4th generation)")
}

@available(iOS 13.0, *)
extension PreviewDevice: Hashable {}
