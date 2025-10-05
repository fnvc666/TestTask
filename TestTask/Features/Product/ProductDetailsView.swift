//
//  ProductDetailsView.swift
//  TestTask
//
//  Created by Pavel Pavel on 05/10/2025.
//

import SwiftUI

struct ProductDetailsView: View {
    @StateObject var vm: ProductDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(vm.product.title)
                        .font(.title)
                        .bold()
                    Text("ID: \(vm.product.id)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(vm.product.description)
                        .font(.body)
                }
                Spacer()
                Text(String(format: "%.2f$", vm.product.price))
                    .bold()
            }

            HStack() {
                Button {
                    vm.toggleFavorite()
                } label: {
                    Label(vm.isFavorite ? "Убрать из избранного" : "В избранное",
                          systemImage: vm.isFavorite ? "heart.slash" : "heart")
                }
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button {
                    vm.addToCart()
                } label: {
                    Label("В корзину", systemImage: "cart.badge.plus")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding()
        .navigationTitle(vm.product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
