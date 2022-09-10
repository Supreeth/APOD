//
//  ImageExtension.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

extension UIImage {
    
    convenience init?(fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: 1.0)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
    func save(fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print("Unable to Write \(fileName) Image Data to Disk")
            }
        }
    }
}
