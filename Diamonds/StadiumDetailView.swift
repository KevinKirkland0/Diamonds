import SwiftUI
import CoreData

struct StadiumDetailView: View {
    @ObservedObject var stadium: Stadium
    @Environment(\.managedObjectContext) var viewContext
    @State private var showingImagePicker = false
    @State private var selectedImages: [IdentifiableImage] = []
    @State private var showDeleteOptions = false
    @State private var deleteImage: IdentifiableImage?
    @State private var selectedImage: IdentifiableImage?
    
    var fetchedImages: FetchedResults<Image> {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Image.timestamp, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "stadium == %@", argumentArray: [stadium])
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch images: \(error)")
            return []
        }
    }
    
    let gridItemLayout = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ZStack {
            if let imageData = fetchedImages.first?.imageData,
               let image = UIImage(data: imageData) ?? UIImage(named: "defaultImage") {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.clear
            }
            
            VStack(spacing: 16) {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 8) {
                        ForEach(fetchedImages, id: \.self) { image in
                            VStack {
                                if let imageData = image.imageData,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                                        .cornerRadius(8)
                                        .padding(.vertical, 4)
                                        .onTapGesture {
                                            // Handle tap gesture
                                        }
                                        .onLongPressGesture {
                                            // Handle long press gesture
                                        }
                                        .contextMenu {
                                            Button(action: {
                                                withAnimation {
                                                    deleteImage(deleteImage!)
                                                    showDeleteOptions = false
                                                    deleteImage = nil
                                                }
                                            }) {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                
                Toggle("Visited", isOn: $stadium.visited)
                    .padding()
                
                Button("Upload Photos") {
                    showingImagePicker = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showingImagePicker, onDismiss: saveImages) {
                ImagePicker(selectedImages: Binding(
                    get: { selectedImages.map { $0.image } },
                    set: { selectedImages = $0.map { IdentifiableImage(id: UUID(), image: $0) } }
                ))
            }
            .fullScreenCover(item: $selectedImage) { image in
                if let imageData = image.imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            selectedImage = nil
                        }
                }
            }
        }
    }
    
    func saveImages() {
        for image in selectedImages {
            guard let imageData = image.imageData else {
                continue
            }
            
            let imageEntity = Image(context: viewContext)
            imageEntity.imageData = imageData
            imageEntity.timestamp = Date()
            imageEntity.stadium = stadium
            
            do {
                try viewContext.save()
            } catch {
                print("Failed to save image: \(error)")
            }
        }
    }
    
    func deleteImage(_ image: IdentifiableImage) {
        if let index = selectedImages.firstIndex(where: { $0 == image }) {
            selectedImages.remove(at: index)
            
            let imageEntity = fetchedImages[index]
            
            DispatchQueue.main.async {
                viewContext.delete(imageEntity)
                
                do {
                    try viewContext.save()
                } catch {
                    print("Failed to delete image: \(error)")
                }
            }
        }
    }
}

struct IdentifiableImage: Identifiable, Equatable {
    let id: UUID
    let imageData: Data
}

struct StadiumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let stadium = Stadium(context: context)
        stadium.name = "Sample Stadium"
        return StadiumDetailView(stadium: stadium)
            .environment(\.managedObjectContext, context)
    }
}
    