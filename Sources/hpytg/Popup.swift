//
//  Popup.swift
//  hpytg
//
//  Created by 雨雪菲菲 on 11/28/25.
//

import SwiftUICore
//import UIKit
import SwiftUI

public struct Popup: View {

@Binding var isPresented: Bool
//let content: Content
let dismissOnTapOutside: Bool
    var platform : String = "2"
private let buttonSize: CGFloat = 24
    
//    init(isPresented: Binding<Bool>,
//         dismissOnTapOutside: Bool = true,
//         @ViewBuilder _ content: () -> Content) {
//
//#if (os(iOS))
//platform = "2"
//#elseif (os(macOS))
//platform = "5"
//#endif
//
//        _isPresented = isPresented
//        self.dismissOnTapOutside = dismissOnTapOutside
//        self.content = content()
//    }

    public var body: some View {

    GeometryReader { geometry in
        
        ZStack {

        Rectangle()
        .fill(.gray.opacity(0.7))
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
            width: platform == "2" ? geometry.size.width*0.8:geometry.size.height*0.4  , height: geometry.size.height*0.8)
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
        })
        .font(.system(size: 24, weight: .bold, design: .default))
        .foregroundStyle(Color.gray.opacity(0.7))
        .padding(.all, 8)
        }
        }
        //.ignoresSafeArea(.all)
        .frame(
        width: geometry.size.width,
        height: geometry.size.height,
        alignment: .center
        )
        }
        
        
        
           }
    
    
    


}


extension Popup {
//    ,
//    @ViewBuilder _ content: () -> Content
    init(isPresented: Binding<Bool>,
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
