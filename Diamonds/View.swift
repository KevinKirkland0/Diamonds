import SwiftUI
import CoreData

//testing

struct StadiumDetailView: View {
    @ObservedObject var stadium: Stadium
    @Environment(\.managedObjectContext) var viewContext  // Add this line
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            // Stadium name at the top
            Text(stadium.name ?? "Unknown Stadium")
                .font(.custom("NewYork", size: 39))  // replace "YourFontName" with the actual name of your font
                .bold()
                .padding(.top)
            
            
            // The rest of the content in a ScrollView
            ScrollView {
                // Display the selected image, if there is one
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                // Add a toggle to mark the stadium as visited
                Toggle("Visited", isOn: $stadium.visited)
                    .padding()
                
                // Add a button to open the image picker
                Button("Upload Image") {
                    showingImagePicker = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Show the image picker when the button is tapped
                          if showingImagePicker {
                              ImagePicker(selectedImage: $selectedImage)
                                  .onDisappear {
                                      showingImagePicker = false
                                      if let image = selectedImage {
                                          stadium.imageData = image.jpegData(compressionQuality: 1.0)
                                          do {
                                              try viewContext.save()
                                          } catch {
                                              print("Failed to save image data: \(error)")
                                          }
                                      }
                                  }
                          }

                          // Display the selected image, if there is one
                          if let imageData = stadium.imageData, let image = UIImage(data: imageData) {
                              Image(uiImage: image)
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                          }
                      }
                  }
              }
}




