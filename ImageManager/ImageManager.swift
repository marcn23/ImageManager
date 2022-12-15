//
//  ImageManager.swift
//  ImageManager
//
//  Created by Marc Navarro on 29/11/22.
//

import Foundation
import UIKit

struct APIImage: Codable{
    let ttl: String
    let desc: String
    let keyw: String
    let auth: String
    let creat: String
    let dateC: String
    let dateS: String
    let filen: String
    let id: String
    let portrait: Bool
}

struct APIBook: Codable{
    var Images = [String : APIImage]()
    let imageNumber: Int
}

public final class ImageManager: NSObject {
   
    var imagenes = [String]()
    
    var BookRecord = Book()
    
    public var completionHandler: ((Book) -> Void)?
    
    let urlString: String
    
    public override init() {
        urlString = "https://680a-37-133-181-255.eu.ngrok.io/Practica4/resources/javaee8/"
    }
    
    
    public func getImages() async -> Book {
            var n = 0
            guard let url = URL(string: self.urlString + "list") else{
                return BookRecord
            }
            do{
                let (data,  _) = try await URLSession.shared.data(from: url)
                if let response = try? JSONDecoder().decode(APIBook.self, from: data){
                    let bookResult = await Book(response: response)
                    self.completionHandler?(bookResult)
                    self.BookRecord = bookResult
                    //print(bookResult.imageNumber)
               
                    for(key,value) in bookResult.Images{
                        print("")
                        print("Image: " + key + ", Atributes:")
                        print(value.ttl)
                        print(value.desc)
                        print(value.keyw)
                        print(value.auth)
                        print(value.creat)
                        print(value.dateC)
                        print(value.dateS)
                        print(value.portrait)
                        print("")
                        imagenes.append(value.ttl)
                        n = n+1
                        print(imagenes, n)
                    }
                }
            }
            catch{
                print("invalid data")
            }
            //print("Number2: ", self.BookRecord.imageNumber)
            return BookRecord
        }

    public func downloadImg(idImg: String) async -> UIImage{
        let urlM = URL(string: urlString + "getImage/" + idImg)
        var img: UIImage
        let (data,  _) = try! await URLSession.shared.data(from: urlM!)
        img = UIImage(data: data)!
        return img
    }
    
    public func deleteImage(id: String, creator: String) async{
        let data : Data = "id=\(id)&creator=\(creator)".data(using: .utf8)!
        let urlM = URL(string: urlString + "delete")
        var request = URLRequest(url: urlM!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        print("Request: ", request)
        
        let (APIdata, _) = try! await URLSession.shared.data(for: request)
    }
    
}
