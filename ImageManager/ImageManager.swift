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

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    var httpBody = NSMutableData()
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.appendString(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    
    func addDataField(fieldName: String, fileName: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(fieldName: fieldName,fileName:fileName,data: data, mimeType: mimeType))
    }
    
    private func dataFormField(fieldName: String,
                               fileName: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.appendString("--\(boundary)\r\n")
        fieldData.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        fieldData.appendString("Content-Type: \(mimeType)\r\n")
        fieldData.appendString("\r\n")
        fieldData.append(data)
        fieldData.appendString("\r\n")
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

public final class ImageManager: NSObject {
   
    var imagenes = [String]()
    
    var BookRecord = Book()
    
    public var completionHandler: ((Book) -> Void)?
    
    let urlString: String
    
    public override init() {
        urlString = "https://f081-37-133-181-255.eu.ngrok.io/Practica4/resources/javaee8/"
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

        
    public func modifyImage(id: String, title: String, description: String, keywords: String, author: String, creator: String, capture: String, oldFilename: String, filename: String, modified: String, img: UIImage) async{
        print (id + " " + title + " " + description + " " + keywords)

        let urlM = URL(string: urlString + "modify")
        
        //Boundary for MultiPart POST.
        let request = MultipartFormDataRequest(url: urlM!)
        request.addTextField(named: "id", value: id)
        request.addTextField(named: "title", value: title)
        request.addTextField(named: "description", value: description)
        request.addTextField(named: "keywords", value: keywords)
        request.addTextField(named: "author", value: author)
        request.addTextField(named: "creator", value: creator)
        request.addTextField(named: "capture", value: capture)
        request.addTextField(named: "oldFilename", value: oldFilename)
        request.addTextField(named: "filename", value: filename)
        request.addTextField(named: "modified", value: modified)
        request.addDataField(fieldName: "image", fileName: oldFilename , data: img.pngData()!, mimeType: "image/*")
        
        let (APIdata, _) = try! await URLSession.shared.data(for: request.asURLRequest())
    }
    
    public func registerImage(title: String, description: String, keywords: String, author: String, creator: String, capture: String, filename: String, img: UIImage) async{
        let urlM = URL(string: urlString + "register")
        
        //Boundary for MultiPart POST.
        let request = MultipartFormDataRequest(url: urlM!)
        request.addTextField(named: "title", value: title)
        request.addTextField(named: "description", value: description)
        request.addTextField(named: "keywords", value: keywords)
        request.addTextField(named: "author", value: author)
        request.addTextField(named: "creator", value: creator)
        request.addTextField(named: "capture", value: capture)
        request.addTextField(named: "filename", value: filename)
        request.addDataField(fieldName: "image", fileName: filename, data: img.pngData()!, mimeType: "image/*")
        print(request)
        let (APIdata, _) = try! await URLSession.shared.data(for: request.asURLRequest())
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
