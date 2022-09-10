//
//  FileHelper.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import UIKit

struct FileHelper {
    func save(fileName: String, imageData: Data?) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = imageData {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print("Unable to Write \(fileName) Image Data to Disk")
            }
        }
    }
    
    func getImage(with fileName: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}
