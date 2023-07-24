//
//  ProductSectionView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct ProductSectionView: View {
    
    @State var title: String.LocalizationValue
    @Binding var products: [Product]
    
    var onItemTap: ((Product) -> Void)?
    
    let columns = [ GridItem(.adaptive(minimum: 180), spacing: 0, alignment: .center) ]
    
    var body: some View {
        VStack (alignment: .leading){
            Text(String(localized: title))
                .listGroupText()
                .padding(.horizontal, 20)
            
            LazyVGrid(columns:  columns, spacing: 0) {
                ForEach(products) { p in
                    ProductItemView(product: p)
                        .padding(.bottom, 8)
                        .onTapGesture {
                            if let onItemTap = onItemTap {
                                onItemTap(p)
                            }
                        }
                }
            }
        }
    }
}

struct ProductSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSectionView(title: "Section", products: .constant(dev.products), onItemTap: nil)
    }
}

extension ProductSectionView {
    
    fileprivate var listView: some View {
        LazyHStack (spacing: 8) {
           
        }
        .padding()
    }
    
}
