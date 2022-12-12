//
//  ImageManager.swift
//  ImageManager
//
//  Created by Marc Navarro on 29/11/22.
//

import Foundation

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
        urlString = "https://df85-93-176-139-124.eu.ngrok.io/Practica4/resources/javaee8/list"
    }
    
    
    public func getImages() async -> Book {
            var n = 0
            guard let url = URL(string: self.urlString) else{
                return BookRecord
            }
            do{
                let (data,  _) = try await URLSession.shared.data(from: url)
                if let response = try? JSONDecoder().decode(APIBook.self, from: data){
                    let bookResult = Book(response: response)
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


    
    /*public func downloadImageWorkable(){ //Workable
        let urlM = URL(string: "https://22b0-93-176-134-11.eu.ngrok.io/Practica4/resources/javaee8/getImage/1685")
        
        let dataTask = URLSession.shared.dataTask(with: urlM!){ data, response, error in
            if data != nil, error == nil {
                DispatchQueue.global().async {
                    self.imageView.image = UIImage(data: data!)
                    print("Data will be displayed")
                }
            }
        }
        dataTask.resume()
    }*/
    
    /*
     public func downloadImage(imgURL: URL, completion: @escaping (Data?, Error?) -> (Void)){
         if let imageData = imageView.object(forKey: imgURL.absoluteString as NSString) {
               print("Alredy got that Image!")
               completion(imageData as Data, nil)
               return
             }
         
         guard let url = URL(string: imgURL) else{
             return
         }
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data, error == nil else{
                 return
             }
             do{
                 //let response = try JSONSerialization.jsonObject(with:data, options: .allowFragments)
                 //print(response)
                 if let response = try? JSONDecoder().decode(APIBook.self, from: data){
                     let bookResult = Book(response: response)
                     self.completionHandler?(bookResult)
                     print(bookResult.imageNumber)
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
                     }
                 }
             }
         }
         task.resume()
         
     }*/
     
}
