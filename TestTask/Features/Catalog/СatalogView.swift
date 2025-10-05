//
//  СatalogView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var vm: CatalogViewModel
    
    @EnvironmentObject private var productsStore: ProductsStore
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @EnvironmentObject private var cartStore: CartStore
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView()
                } else if vm.filtered.isEmpty {
                    Text("No such product was found")
                }
                else {
                    List(vm.filtered) { item in
                        NavigationLink(value: item) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title).font(.headline)
                                    Text(item.description)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 6) {
                                    Text(String(format: "%.2f$", item.price)).bold()
                                    Image(systemName: vm.isFavorite(item.id) ? "heart.fill" : "heart")
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Product.self) { product in
                        ProductDetailsView(vm: .init(product: product, favorites: favoritesStore, cart: cartStore))
                    }
                }
            }
            .searchable(text: $vm.query, prompt: "Search")
            .navigationTitle("Catalog")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        FavoriteView(vm: .init(products: productsStore, favorites: favoritesStore))
                    } label: { Image(systemName: "heart.fill") }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CartView()
                    } label: { Image(systemName: "cart.fill") }
                }
            }
        }
        .task { await vm.load() }
    }
}
