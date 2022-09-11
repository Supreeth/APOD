//
//  FileHelper.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import UIKit

struct FileHelper {
    /**
        Data will get stored in the document directory
        - fileName - Name of the file in which data to be stored
        - imageData - Data to be stored in the file
     */
    func save(fileName: String, data: Data?) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = data {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print("Unable to Write \(fileName) Image Data to Disk")
            }
        }
    }
    
    /**
        Retrieves the image from the document directoyr
        - fileName - Name of the file in which image is stored
        - Returns back UIImage
     */
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
