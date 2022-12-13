//
//  ContentView.swift
//  Sustainable Calculator
//
//  Created by Toby on 25/08/2022.
//

//importing dependencies
import SwiftUI
import CodeScanner
import Firebase
import Foundation

struct ContentView: View {
    //bool opertation for scanner
    @State var isPresentingScanner = false
    
    //Var for bar code
    @State public var scannedCode: String = "Scan a bar code to get started."
    
    // database test
    @ObservedObject var model = ViewModel()
    
    
    
    
    

    //scanning bar code
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr, .code128, .ean13, .ean8],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                     
                    //getting info from the database
                    model.lookupCode(barCode: code.string)
                    //model.getData()
                    
                }
            }
        )
    }
      

    var body: some View {
        VStack(spacing: 10) {
            
            //shows what you scanned
            Text(scannedCode)

            //result from database
            //Text(newItem)
            
            // displaying database info
            List (model.list) { item in
                Text(item.name)
                
            //styling for the list
            }.frame(width: 200, height: 300, alignment: .topLeading)
            

            
            Button("Scan Code") {
                self.isPresentingScanner = true
            }
            
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//sustainable calculator -> what fields are there
//data base for sustainability
//decide what heppens with the new item?
// send email is there the 3 above?


 


