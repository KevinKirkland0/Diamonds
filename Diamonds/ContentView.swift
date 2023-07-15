import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Stadium.entity(), sortDescriptors: [])
    private var stadiums: FetchedResults<Stadium>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stadiums) { stadium in
                    NavigationLink(destination: StadiumDetailView(stadium: stadium)) {
                        Text(stadium.name ?? "")
                    }
                }
            }
            .navigationTitle("Stadiums")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared // Use your custom PersistenceController instance here
        ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

