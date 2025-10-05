//
//  FavoriteView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var vm: FavoriteViewModel
    
    var body: some View {
        Group {
            if vm.filtered.isEmpty {
                Text("Пока пусто")
            } else {
                List {
                    ForEach(vm.filtered) { product in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            Spacer()
                            Text(String(format: "%.2f$", product.price))
                                .bold()
                            
                            Button {
                                vm.remove(product.id)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .padding(5)
                            }
                            .buttonStyle(.plain)

                        }
                    }
                }
            }
        }
        .searchable(text: $vm.query, placement: .navigationBarDrawer(displayMode: .always),  prompt: "Search")
        .navigationTitle("Favorites")
    }
}

