import SwiftUI

@main
struct CacheHeadersDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RequestsView()
                .onAppear(perform: {
                    let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                    print("Cache.db location: \(paths.debugDescription)")
                })
        }
    }
}
