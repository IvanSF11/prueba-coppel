//
//  HomeInteractor.swift
//  prueba-coppel
//
//  Created Pedro Soriano on 27/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomeInteractor: HomeInteractorProtocol {
    
    private let apiKey = "e00065673fed8cfa9e337ca04422cd53"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    weak var presenter: HomePresenterProtocol?
    
    func fetchMovies(type: typeMovies) {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(type.rawValue)") else {
            errorService()
            return
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            self.errorService()
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.errorService()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.errorService()
                return
            }
            
            guard let data = data else {
                self.errorService()
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.responseMovies(data: response)
                }
            } catch {
               self.errorService()
            }
        }.resume()
    }
    
    func fetchTV(type: typeTV) {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/tv/\(type.rawValue)") else {
            errorService()
            return
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            self.errorService()
            return
        }
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.errorService()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.errorService()
                return
            }
            
            guard let data = data else {
                self.errorService()
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(TVResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.responseTV(data: response)
                }
            } catch {
                self.errorService()
            }
        }.resume()
        
    }
    
    func initDateBase(){
        PersonalDataDataBase.shared.assign()
    }
    
    func updateDatabase(values: [MoviesValue]) {
        for field in values {
            do {
                try PersonalDataDataBase.shared.insert(field, in: .personalData)
            } catch {
                debugPrint("DEBUG: DB Failed to add items", error)
            }
        }
    }
    
    func updateDatabase(_ value: MoviesValue) {
        do {
            try PersonalDataDataBase.shared.insert(value, in: .personalData)
        } catch {
            debugPrint("DEBUG: DB Failed to add items", error)
        }
    }
    
    func getDatabaseData() -> [MoviesValue]? {
        do {
            let table = try PersonalDataDataBase.shared.getAllFields(in: .personalData)
            debugPrint("DEBUG: The Table", table)
            return table
        } catch {
            debugPrint("DEBUG: DB unable to get all fields", error)
        }
        return nil
    }
    
    func deleteRowData(_ id: Int) {
        PersonalDataDataBase.shared.deleteRow(.personalData, id: id)
    }
    
    private func errorService(){
        presenter?.showError(title: "unable to connect to the service")
    }
}