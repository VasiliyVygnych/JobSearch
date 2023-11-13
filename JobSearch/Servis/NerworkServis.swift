//
//  NerworkServis.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit

class NetworkServis: NetworkServisProtocol {
//MARK: - request
    func request(urlString: URL,
                 completion: @escaping ( Result <Data, Error>) -> Void) {
        let token = "APPLGB7AOAPSSJRDCU9PSLSGM7HIVNGMP9VJBH9NH1BF7IA52MK3FVGIGCVPH5LL"
        var request = URLRequest(url: urlString)
        request.setValue("Bearer \(token)",
                         forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
        }.resume()
    }
//MARK: - searchVacancies
    func searchVacancies(searchText: String,
                         id: Int,
                         completion: @escaping (JobsData?) -> Void) {
        var components = URLComponents(string: "https://api.hh.ru/vacancies")
        components?.queryItems = [URLQueryItem(name: "per_page",
                                               value: String(id)),
                                  URLQueryItem(name: "text",
                                               value: searchText)]
        guard let url = components?.url else { return }
        request(urlString: url) { (result)  in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(JobsData.self,
                                                         from: data)
                    completion(model)
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
//MARK: - detail vacancies
    func detailVacancies(id: String,
                     completion: @escaping (ItemData?) -> Void) {
        let reguest = URL(string: "https://api.hh.ru/vacancies/\(id)")
        guard let url = reguest else { return }
        request(urlString: url) { (result)  in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ItemData.self,
                                                         from: data)
                    completion(model)
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
