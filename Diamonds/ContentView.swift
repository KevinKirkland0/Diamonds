import SwiftUI
import MapKit


class Stadium: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let image: String
    @Published var visited: Bool
    @Published var notes = ""
    
    init(name: String, coordinate: CLLocationCoordinate2D, image: String, visited: Bool = false) {
        self.name = name
        self.coordinate = coordinate
        self.image = image
        self.visited = visited
    }
}

    struct ContentView: View {
        @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.50, longitude: -98.35), // Center of the continental United States
            span: MKCoordinateSpan(latitudeDelta: 42.0256, longitudeDelta: 58.8354) // Further reduced span to zoom in
        )
        
            
            @State var stadiums: [Stadium] = [
                Stadium(name: "Fenway Park", coordinate: CLLocationCoordinate2D(latitude: 42.346676, longitude: -71.097218), image: "fenway_park_image"),
                Stadium(name: "Yankee Stadium", coordinate: CLLocationCoordinate2D(latitude: 40.829643, longitude: -73.926175), image: "yankee_stadium_image"),
                Stadium(name: "Dodger Stadium", coordinate: CLLocationCoordinate2D(latitude: 34.073851, longitude: -118.239958), image: "dodger"),
                Stadium(name: "Wrigley Field", coordinate: CLLocationCoordinate2D(latitude: 41.948438, longitude: -87.655333), image: "wrigley_field_image"),
                Stadium(name: "Oracle Park", coordinate: CLLocationCoordinate2D(latitude: 37.778595, longitude: -122.389270), image: "oracle_park_image"),
                Stadium(name: "American Family Field", coordinate: CLLocationCoordinate2D(latitude: 43.028078, longitude: -87.971212), image: "american_family_field_image"),
                Stadium(name: "Angel Stadium", coordinate: CLLocationCoordinate2D(latitude: 33.800308, longitude: -117.882732), image: "angel_stadium_image"),
                Stadium(name: "Busch Stadium", coordinate: CLLocationCoordinate2D(latitude: 38.622619, longitude: -90.192821), image: "busch_stadium_image"),
                Stadium(name: "Chase Field", coordinate: CLLocationCoordinate2D(latitude: 33.445526, longitude: -112.066721), image: "chase_field_image"),
                Stadium(name: "Citi Field", coordinate: CLLocationCoordinate2D(latitude: 40.757088, longitude: -73.845821), image: "citi_field_image"),
                Stadium(name: "Citizens Bank Park", coordinate: CLLocationCoordinate2D(latitude: 39.906057, longitude: -75.166495), image: "citizens_bank_park_image"),
                Stadium(name: "Comerica Park", coordinate: CLLocationCoordinate2D(latitude: 42.339227, longitude: -83.048695), image: "comerica_park_image"),
                Stadium(name: "Coors Field", coordinate: CLLocationCoordinate2D(latitude: 39.756980, longitude: -104.994178), image: "coors_field_image"),
                Stadium(name: "Globe Life Field", coordinate: CLLocationCoordinate2D(latitude: 32.747299, longitude: -97.082487), image: "globe_life_field_image"),
                Stadium(name: "Great American Ball Park", coordinate: CLLocationCoordinate2D(latitude: 39.097389, longitude: -84.506611), image: "great_american_ball_park_image"),
                Stadium(name: "Guaranteed Rate Field", coordinate: CLLocationCoordinate2D(latitude: 41.829922, longitude: -87.633800), image: "guaranteed_rate_field_image"),
                Stadium(name: "Kauffman Stadium", coordinate: CLLocationCoordinate2D(latitude: 39.051672, longitude: -94.480579), image: "kauffman_stadium_image"),
                Stadium(name: "LoanDepot Park", coordinate: CLLocationCoordinate2D(latitude: 25.777962, longitude: -80.219517), image: "loandepot_park_image"),
                Stadium(name: "Minute Maid Park", coordinate: CLLocationCoordinate2D(latitude: 29.757268, longitude: -95.355514), image: "minute_maid_park_image"),
                Stadium(name: "Nationals Park", coordinate: CLLocationCoordinate2D(latitude: 38.873010, longitude: -77.007433), image: "nationals_park_image"),
                Stadium(name: "Oakland Coliseum", coordinate: CLLocationCoordinate2D(latitude: 37.751595, longitude: -122.200546), image: "oakland_coliseum_image"),
                Stadium(name: "Oriole Park at Camden Yards", coordinate: CLLocationCoordinate2D(latitude: 39.283964, longitude: -76.621618), image: "oriole_park_at_camden_yards_image"),
                Stadium(name: "Petco Park", coordinate: CLLocationCoordinate2D(latitude: 32.707649, longitude: -117.157036), image: "petco_park_image"),
                Stadium(name: "PNC Park", coordinate: CLLocationCoordinate2D(latitude: 40.446915, longitude: -80.005666), image: "pnc_park_image"),
                Stadium(name: "Progressive Field", coordinate: CLLocationCoordinate2D(latitude: 41.496211, longitude: -81.685229), image: "progressive_field_image"),
                Stadium(name: "Rogers Centre", coordinate: CLLocationCoordinate2D(latitude: 43.641438, longitude: -79.389353), image: "rogers_centre_image"),
                Stadium(name: "T-Mobile Park", coordinate: CLLocationCoordinate2D(latitude: 47.591358, longitude: -122.332283), image: "t_mobile_park_image"),
                Stadium(name: "Target Field", coordinate: CLLocationCoordinate2D(latitude: 44.981762, longitude: -93.277514), image: "target_field_image"),
                Stadium(name: "Tropicana Field", coordinate: CLLocationCoordinate2D(latitude: 27.768225, longitude: -82.653392), image: "tropicana_field_image"),
                Stadium(name: "Truist Park", coordinate: CLLocationCoordinate2D(latitude: 33.890840, longitude: -84.467830), image: "truist_park_image")
            ]

        
        @State private var selectedView = 0
        
        var body: some View {
            NavigationView {
                VStack {
                    if selectedView == 0 {
                        Map(coordinateRegion: $region, annotationItems: stadiums) { stadium in
                            MapAnnotation(coordinate: stadium.coordinate) {
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
                                        Text(stadium.name)
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
