//
//  AdView.swift
//  hpytg
//
//  Created by 雨雪菲菲 on 12/29/25.
//
//
//  Popup.swift
//  hpytg
//
//  Created by 雨雪菲菲 on 11/28/25.
//

import SwiftUICore
//import UIKit
import SwiftUI

public struct AdView: View {

@Binding var isPresented: Bool
//let content: Content
let dismissOnTapOutside: Bool
    var platform : String = "2"
private let buttonSize: CGFloat = 24
    @State private var screenSize: CGSize = .zero
//    public init(isPresented: Binding<Bool>
//         ) {
//
////#if (os(iOS))
////platform = "2"
////#elseif (os(macOS))
////platform = "5"
////#endif
////
////        _isPresented = isPresented
////        self.dismissOnTapOutside = dismissOnTapOutside
////        self.content = content()
//    }

    
    
    public var body: some View {
       // @Environment(\.presentationMode) var presentationMode
    GeometryReader { geometry in
        
        ZStack {

        Rectangle()
        .fill(Color.clear)
        .ignoresSafeArea()
        .onTapGesture {
        if dismissOnTapOutside {
        withAnimation {
        isPresented = false
        }
        }
        }

            ContentView()
        .frame(
            width: platform == "2" ? geometry.size.width*1:geometry.size.height*0.5  , height: geometry.size.height*1)
        .padding()
        .padding(.top, buttonSize)
        .background(.white)
        .cornerRadius(12)
        .overlay(alignment: .topTrailing) {
        Button(action: {
        withAnimation {
        isPresented = false
        }
        }, label: {
        Image(systemName: "xmark.circle")
        }).frame(width: 30, height: 30)
        .font(.system(size: 24, weight: .bold, design: .default))
        .foregroundStyle(Color.gray.opacity(0.7))
        .padding(.all, 30)
        }
        }.background(Color.clear)
        //.ignoresSafeArea(.all)
        .frame(
        width: geometry.size.width,
        height: geometry.size.height,
        alignment: .center
        )
    }.background(Color.clear)
    }
    
    
    


}


extension AdView {
//    ,
//    @ViewBuilder _ content: () -> Content
    public init(isPresented: Binding<Bool>,
         dismissOnTapOutside: Bool = true) {
       
        #if (os(iOS))
        platform = "2"
        #elseif (os(macOS))
        platform = "5"
        #endif
        
        _isPresented = isPresented
        self.dismissOnTapOutside = dismissOnTapOutside
//        self.content = content()
    }
}

