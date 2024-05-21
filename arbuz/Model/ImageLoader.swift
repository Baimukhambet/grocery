import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var url: URL?
    private var cache = NSCache<NSURL, UIImage>()
    private var cancellable: AnyCancellable?

    func load(from url: URL) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        self.url = url
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in
                if let image = $0 {
                    self?.cache.setObject(image, forKey: url as NSURL)
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct MyAsyncImage: View {
    @StateObject private var loader = ImageLoader()
    private let url: URL
    private let placeholder: Image

    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        imageView
            .onAppear {
                loader.load(from: url)
            }
            .onDisappear {
                loader.cancel()
            }
    }

    private var imageView: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .resizable()
            }
        }
    }
}
