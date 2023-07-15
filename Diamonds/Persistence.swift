import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Diamonds")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
    }





    private func initializeStadiumData() {
        let viewContext = container.viewContext
        let _: NSFetchRequest<Stadium> = Stadium.fetchRequest()

        // Rest of the code to initialize stadium data...
    }
}



    
func initializeStadiumData(container: NSPersistentCloudKitContainer) {
    let viewContext = container.viewContext
    let fetchRequest: NSFetchRequest<Stadium> = Stadium.fetchRequest()

    // Rest of the code to initialize stadium data...
        
        do {
            fetchRequest.entity = Stadium.entity() // Configure the fetch request to fetch Stadium entities
            
            let stadiumCount = try viewContext.count(for: fetchRequest)
            print("Stadium count: \(stadiumCount)") // Log the count of fetched stadiums
            
            // Only insert data if there are no existing stadiums
            if stadiumCount == 0 {
                let stadiumData = [
                    // American League East
                    (name: "Fenway Park", latitude: 42.346676, longitude: -71.097218, image: "fenwayImage", visited: false, notes: ""),
                    (name: "Yankee Stadium", latitude: 40.829643, longitude: -73.926175, image: "yankeeImage", visited: false, notes: ""),
                    (name: "Oriole Park at Camden Yards", latitude: 39.284101, longitude: -76.621345, image: "camdenYardsImage", visited: false, notes: ""),
                    (name: "Rogers Centre", latitude: 43.641437, longitude: -79.389353, image: "rogersCentreImage", visited: false, notes: ""),
                    (name: "Tropicana Field", latitude: 27.7683, longitude: -82.6534, image: "tropicanaImage", visited: false, notes: ""),
                    
                    // American League Central
                    (name: "Guaranteed Rate Field", latitude: 41.830883, longitude: -87.635083, image: "guaranteedRateFieldImage", visited: false, notes: ""),
                    (name: "Progressive Field", latitude: 41.495149, longitude: -81.685209, image: "progressiveFieldImage", visited: false, notes: ""),
                    (name: "Comerica Park", latitude: 42.339762, longitude: -83.048508, image: "comericaParkImage", visited: false, notes: ""),
                    (name: "Kauffman Stadium", latitude: 39.051613, longitude: -94.480365, image: "kauffmanStadiumImage", visited: false, notes: ""),
                    (name: "Target Field", latitude: 44.9817, longitude: -93.2773, image: "targetFieldImage", visited: false, notes: ""),
                    
                    // American League West
                    (name: "Minute Maid Park", latitude: 29.7573, longitude: -95.3557, image: "minuteMaidImage", visited: false, notes: ""),
                    (name: "Oakland Coliseum", latitude: 37.7516, longitude: -122.2005, image: "oaklandColiseumImage", visited: false, notes: ""),
                    (name: "T-Mobile Park", latitude: 47.5914, longitude: -122.3327, image: "tMobileParkImage", visited: false, notes: ""),
                    (name: "Globe Life Field", latitude: 32.7512, longitude: -97.0822, image: "globeLifeFieldImage", visited: false, notes: ""),
                    (name: "Angel Stadium of Anaheim", latitude: 33.8003, longitude: -117.8827, image: "angelStadiumImage", visited: false, notes: ""),
                    
                    // National League East
                    (name: "SunTrust Park", latitude: 33.8908, longitude: -84.4676, image: "sunTrustParkImage", visited: false, notes: ""),
                    (name: "Nationals Park", latitude: 38.873, longitude: -77.0074, image: "nationalsParkImage", visited: false, notes: ""),
                    (name: "Marlins Park", latitude: 25.7781, longitude: -80.2197, image: "marlinsParkImage", visited: false, notes: ""),
                    (name: "Citizens Bank Park", latitude: 39.9056, longitude: -75.1667, image: "citizensBankParkImage", visited: false, notes: ""),
                    (name: "Citi Field", latitude: 40.7571, longitude: -73.8458, image: "citiFieldImage", visited: false, notes: ""),
                    
                    // National League Central
                    (name: "Wrigley Field", latitude: 41.948438, longitude: -87.655333, image: "wrigleyImage", visited: false, notes: ""),
                    (name: "Miller Park", latitude: 43.028, longitude: -87.9712, image: "millerParkImage", visited: false, notes: ""),
                    (name: "Great American Ball Park", latitude: 39.0979, longitude: -84.5088, image: "greatAmericanBallParkImage", visited: false, notes: ""),
                    (name: "Busch Stadium", latitude: 38.6226, longitude: -90.1928, image: "buschStadiumImage", visited: false, notes: ""),
                    (name: "PNC Park", latitude: 40.4469, longitude: -80.0057, image: "pncParkImage", visited: false, notes: ""),
                    
                    // National League West
                    (name: "Dodger Stadium", latitude: 34.073851, longitude: -118.239958, image: "dodgerImage", visited: false, notes: ""),
                    (name: "Chase Field", latitude: 33.4455, longitude: -112.0667, image: "chaseFieldImage", visited: false, notes: ""),
                    (name: "Petco Park", latitude: 32.7072, longitude: -117.1573, image: "petcoImage", visited: false, notes: ""),
                    (name: "Oracle Park", latitude: 37.778595, longitude: -122.389270, image: "oracleImage", visited: false, notes: ""),
                    (name: "Coors Field", latitude: 39.7559, longitude: -104.9942, image: "coorsImage", visited: false, notes: "")
                ]
                               
                for data in stadiumData {
                    let stadium = Stadium(context: viewContext)
                    stadium.name = data.name
                    stadium.coordinateLatitude = data.latitude
                    stadium.coordinateLongitude = data.longitude
                    stadium.visited = data.visited
                    stadium.notes = data.notes
                    // You no longer have an `image` attribute, but an `imageData` attribute.
                    // You could load the image data here if you have it, but for now, I'll set it to nil.
                    stadium.imageData = nil
                }
                               
                               do {
                                   try viewContext.save()
                               } catch {
                                   let nsError = error as NSError
                                   fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                               }
                           }
                       } catch {
                           let nsError = error as NSError
                           fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                       }
                   }

    

