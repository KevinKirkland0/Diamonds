import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Stadium.name, ascending: true)], animation: .default)
    private var stadiums: FetchedResults<Stadium>
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.50, longitude: -98.35), // Center of the continental United States
        span: MKCoordinateSpan(latitudeDelta: 42.0256, longitudeDelta: 58.8354) // Further reduced span to zoom in
    )
    
    @State private var selectedView = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedView == 0 {
                    Map(coordinateRegion: $region, annotationItems: stadiums) { stadium in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: stadium.coordinateLatitude, longitude: stadium.coordinateLongitude)) {
                            NavigationLink(destination: StadiumDetailView(stadium: stadium)) {
                                Image(systemName: stadium.visited ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 10, height: 10)  // Adjust the size as needed
                                    .shadow(radius: 5)
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(stadiums) { stadium in
                            NavigationLink(destination: StadiumDetailView(stadium: stadium)) {
                                HStack {
                                    Text(stadium.name ?? "")
                                    Spacer()
                                    if stadium.visited {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Stadiums"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $selectedView) {
                        Text("Map").tag(0)
                        Text("List").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
        }
    }
}



