//
//  ContentView.swift
//  hpytg
//
//  Created by 雨雪菲菲 on 11/28/25.
//

import SwiftUI
import CoreData
//import UIKit
import SafariServices
struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
struct ContentView: View {
//    let width:CGFloat
//    let height:CGFloat
    
//    init(width: CGFloat, height: CGFloat,   imgurl: String = "", description: String = "", title: String = "", subtitle: String = "") {
//        self.width = width
//        self.height = height
//        self.imgurl = imgurl
//        self.description = description
//        self.title = title
//        self.subtitle = subtitle
//    }
    @Environment(\.openURL) var openURL
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var imgurl = ""
    @State var description = ""
    @State var title = ""
    @State var subtitle = ""

    
    var body: some View {
        GeometryReader{
            reader in
            VStack{
                
                AsyncImage(url: URL( string:  NetworkService.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: reader.size.width, height: reader.size.height*0.5)
//                            .cornerRadius(10)
//                            .shadow(radius: 10)
                    case .failure:
                        Text("").frame(height: reader.size.height*0.5)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(NetworkService.description).foregroundColor(.gray).frame(maxHeight: .infinity).padding(EdgeInsets(top:5,leading:5,bottom: 5,trailing: 5))
                HStack(){
//                    GeometryReader{
//                        reader in
//
//                    }
                    AsyncImage(url: URL( string:  NetworkService.icon)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: reader.size.width*0.15, height: reader.size.width*0.15)
    //                            .cornerRadius(10)
    //                            .shadow(radius: 10)
                        case .failure:
                            Text("").frame(height: reader.size.width*0.15)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    
                    
                    VStack(){
                        Text(NetworkService.title).font(.system(size: 20)).padding(EdgeInsets(top:0,leading:5,bottom: 0,trailing: 0))
                        Text(NetworkService.subtitle).foregroundColor(.gray).font(.system(size: 16)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        
                    }
                    Spacer()
//                    Text("").frame(maxWidth: .infinity)
                    Button(action: {
#if(os(iOS))
                        if let url = URL(string: NetworkService.url) {
                                        // 创建SFSafariViewController实例
                                        let safariViewController = SFSafariViewController(url: url)
                                        // 确保你是在视图控制器的环境中，例如在.onAppear或者.sheet中调用
                                        UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true)
                                    }
#elseif (os(macOS))
                        openURL(URL(string: NetworkService.url)!)
#endif
                        
                    }){Text("访问")}.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
         
                
                
            }        }
        .task {
            do {
//                try await loadData()
            } catch {
                print(error)
            }
                    }
        
    }

//    func loadData() async throws -> [Post] {
//        title = "test"
//            let urlString = "https://jsonplaceholder.typicode.com/posts"
//            let url = URL(string: urlString)!
//
//            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
//
//        return try JSONDecoder().decode([Post].self, from: data)
//        }
    
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
