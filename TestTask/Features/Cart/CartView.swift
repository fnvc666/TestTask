//
//  CartView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

struct CartView: View {
    @StateObject var vm: CartViewModel
    
    var body: some View {
        VStack {
            if vm.entries.isEmpty {
                Text("Корзина пуста")
            } else {
                List {
                    ForEach(vm.entries) { entry in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.product.title)
                                    .font(.headline)
                                Text(String(format: "$%.2f", entry.product.price))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Button { vm.decrease(entry.product.id) } label: {
                                    Image(systemName: "minus.circle")
                                }
                                .buttonStyle(.plain)
                                
                                Text("\(entry.amount)")
                                
                                Button { vm.increase(entry.product.id) } label: {
                                    Image(systemName: "plus.circle")
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                }
                
                HStack {
                    Text("Итого:").bold()
                    Spacer()
                    Text(String(format: "$%.2f", vm.total)).bold()
                }
                .padding(.horizontal)
                
                Button(role: .destructive) { vm.clear() } label: {
                    Label("Очистить корзину", systemImage: "trash")
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Корзина")
        .onChange(of: vm.cart.items, { vm.rebuild() })
        .onChange(of: vm.products.products, { vm.rebuild() })
    }
}

