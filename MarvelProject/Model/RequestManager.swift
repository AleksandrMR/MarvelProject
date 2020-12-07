//
//  RequestManager.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import Foundation
import CryptoKit

class RequestManager {
    
    static let shared = RequestManager()
    
    private init() {}
    
    //    MARK: - let
    let baseURL = "http://gateway.marvel.com/v1/public/characters?"
    let ts = NSDate().timeIntervalSince1970.description
    let privateKey = "dbff2432764f6a2679da62736e5ac68c5bec8b82"
    let publicKey = "ca3e130ba6cd59ddeef0a7db3013884a"
   
    //    MARK: - var
    var offsetIndex = 0
    
    //    MARK: - flow funcs
    func sendRequest(completion: @escaping (CharacterDataWrapper?) -> ()) {
        
        let hashMD5 = "\(ts)\(privateKey)\(publicKey)"
        let hashCode = self.MD5(string: hashMD5)
        
        guard let url = URL(string: "\(baseURL)ts=\(ts)&apikey=\(publicKey)&hash=\(hashCode)&offset=\(offsetIndex)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, request, error) in
            if let data = data, error == nil {
                if let dataFromRequest = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) {
                    completion(dataFromRequest)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
