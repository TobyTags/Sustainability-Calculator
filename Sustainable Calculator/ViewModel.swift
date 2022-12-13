//
//  ViewModel.swift
//  Sustainable Calculator
//
//  Created by Toby on 06/12/2022.
//

import Foundation
import Firebase
import FirebaseAnalytics
import FirebaseCore



class ViewModel: ObservableObject {
    
    @Published var list = [products]()

    func getData() {
        // get reference to the database
        let db = Firestore.firestore()
        
        //read the database in correct path
        db.collection("products").getDocuments { snapshot, error in
            
            //check for errors
            if error == nil {
                //no errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        //get all the documents and create products
                        self.list = snapshot.documents.map { d in
                            
                            // Create a producs item for each document returned
                            return products(id: ContentView().scannedCode,
                                            name: d["name"] as? String ?? "",
                                            scannedCode2: d["scannedCode2"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // handle the error
            }
        }
    }
    
    
    func lookupCode(barCode: String) {
            let db = Firestore.firestore()

            let query = db.collection("products").whereField("scannedCode2", isEqualTo: barCode)

            query.getDocuments { snapshot , error in
                guard error == nil else { return }
                if let snapshot = snapshot {
                    for doc in snapshot.documents {
                        let newItem = products(id: doc.documentID,
                                               name: doc["name"] as? String ?? "",
                                               scannedCode2: doc["scannedCode2"] as? String ?? "")
                        DispatchQueue.main.async {
                            self.list.append(newItem)
                        }
                    }
                }
            }
        }
}
