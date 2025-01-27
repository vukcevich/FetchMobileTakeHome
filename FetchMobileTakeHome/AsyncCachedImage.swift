//
//  AsyncCachedImage.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import SwiftUI

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceHolderView: View>: View {
    var url: URL?
    var session: URLSessionProtocol
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeHolder: () -> PlaceHolderView

    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = false

    init(
        url: URL?,
        session: URLSessionProtocol = URLSession.shared,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeHolder: @escaping () -> PlaceHolderView
    ) {
        self.url = url
        self.session = session
        self.content = content
        self.placeHolder = placeHolder
    }

    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeHolder()
                    .onAppear {
                        loadImageIfNeeded()
                    }
            }
        }
    }

    private func loadImageIfNeeded() {
        guard !isLoading else { return }
        isLoading = true

        Task {
            image = await downloadPhoto()
            isLoading = false
        }
    }

    func downloadPhoto() async -> UIImage? {
        do {
            guard let url else { return nil }

            if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
                return UIImage(data: cachedResponse.data)
            }

            let (data, response) = try await session.data(from: url)
            URLCache.shared.storeCachedResponse(
                CachedURLResponse(response: response, data: data),
                for: URLRequest(url: url)
            )
            return UIImage(data: data)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            return nil
        }
    }
}
