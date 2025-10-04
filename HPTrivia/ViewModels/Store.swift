//
//  Store.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 4/10/25.
//

import StoreKit
import Foundation

@MainActor
@Observable
class Store {
  var products: [Product] = []
  var purchased: Set<String> = []
  
  private var updates: Task<Void, Never>? = nil
  
  init() {
    updates = watchForUpdates()
  }
  
  // Load available products
  func loadProducts() async {
    do {
      products = try await Product.products(for: ["hp4", "hp5", "hp6", "hp7"])
      products.sort {
        $0.displayName < $1.displayName
      }
    } catch {
      print("unable to load products: \(error)")
    }
  }
  
  // Purchase a product
  func purchase(_ product: Product) async {
    do {
      let result = try await product.purchase()
      
      switch result {
        // Purchase successful, but now we need to verify receipt transaction
      case .success(let verificationResult):
        
        switch verificationResult {
        case .unverified(let signedType, let verificationError):
          print("Error on \(signedType): \(verificationError)")
          
        case .verified(let signedType):
          purchased.insert(signedType.productID)
          
          await signedType.finish()
        }
        
        // User cancelled or parent disapproved child's purchase request
      case .userCancelled:
        break
        
        // Waiting for some sort of approval
      case .pending:
        break
        
      @unknown default:
        break
      }
    } catch {
      print("unable to purchase product: \(error)")
    }
  }
  
  // Check for purchased products
  private func checkPurchased() async {
    for product in products {
      guard let status = await product.currentEntitlement else { continue }
      
      switch status {
      case .unverified(let signedType, let verificationError):
        print("Error on \(signedType): \(verificationError)")
        
      case .verified(let signedType):
        if signedType.revocationDate == nil {
          purchased.insert(signedType.productID)
          
        } else {
          purchased.remove(signedType.productID)
        }
      }
    }
  }
  
  // Connect with App Store to watch for purchase and transaction updates
  
  private func watchForUpdates() -> Task<Void, Never> {
    Task(priority: .background) {
      for await _ in Transaction.updates {
        await checkPurchased()
      }
    }
  }
}
