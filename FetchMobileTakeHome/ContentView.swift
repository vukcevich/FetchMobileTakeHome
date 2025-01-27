//
//  ContentView.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetchViewModel: FetchViewModel
    var body: some View {
        Group {
            if fetchViewModel.postRecipes.isEmpty {
                EmptyRecipes()
            } else {
                List(fetchViewModel.postRecipes) { recipe in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .top, spacing: 20) {
                            AsyncCachedImage(
                                        url: URL(string: recipe.photoURLSmall ?? ""),
                                        content: { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        },
                                        placeHolder: {
                                            ProgressView()
                                        }
                                    )
                            .frame(height: 80)
                            VStack (alignment: .leading, spacing: 15) {
                                Text(recipe.name ?? "")
                                    .font(.system(size: 17, weight: .semibold, design: .default))
                                Text(recipe.cuisine ?? "")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .frame(alignment: .top)
        .alert(isPresented: $fetchViewModel.showMessage) {
            Alert(
                title: Text("Something went wrong"),
                message: Text("\(fetchViewModel.message)")
            )
        }
        Spacer()
    }
    
}

struct EmptyRecipes: View {
    var body: some View {
        VStack {
            Text("There are no receipes at the moment.")
                .font(.system(size: 17, weight: .semibold, design: .default))
        }
    }
}

#Preview {
    ContentView(fetchViewModel: FetchViewModel())
}
