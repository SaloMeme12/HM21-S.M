//
//  APIService.swift
//  HM21-S.M
//
//  Created by Mcbook Pro on 11.08.22.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    
    func getCountry(complition: @escaping([Country])->(Void) ) {
        
        let urlsString = "https://restcountries.com/v2/all"
        
        guard let url = URL(string: urlsString) else {
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            
            let decoder = JSONDecoder()
            
            if let error = error {
                print(error)
            }
            
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            
            do {
                let object = try decoder.decode([Country].self, from: data)
               
                DispatchQueue.main.async {
                
                    complition(object)
                }
    
                
            }catch let error{
                print(error)
            }
            
          
        }.resume()
        
    }
    
    
}
