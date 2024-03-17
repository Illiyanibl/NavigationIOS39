//
//  NetworkService.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 10.01.24.
//

import Foundation

struct NetworkServiceSession {
    let sessionQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.name = "sessionQueue"
        return queue
    }()
    lazy var session = URLSession(
        configuration: .default,
        delegate: nil,
        delegateQueue: sessionQueue
    )
    static var shared = NetworkServiceSession()
}

struct NetworkService {
    static func requestURL(for url: String, completion: @escaping (Result<Data, NetworkError>) -> Void){
        guard let url = URL(string: url) else {
            print("=== Wrong URL")
            return
        }
        let request = URLRequest(url: url)
        let task = NetworkServiceSession.shared.session.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.custom(description: error.localizedDescription)))
                }
            }
            guard response is HTTPURLResponse else { return }

            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.server))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }


    static func request(for configuration: AppConfiguration){
        //Не очень понял зачем, но по условиям понадобился enum с ассоциированными значениями типа URL или String
        var getUrl: URL?
        switch configuration {
        case .species(let urlFromString):
            guard let url = URL(string: urlFromString ) else { return }
            getUrl = url
        case .vehicles(let urlFromString):
            guard let url = URL(string: urlFromString ) else { return }
            getUrl = url
        case .starships(let urlFromString):
            guard let url = URL(string: urlFromString ) else { return }
            getUrl = url
        }
        guard let url = getUrl else { return }
        let request = URLRequest(url: url)
        let task = NetworkServiceSession.shared.session.dataTask(with: request) { data, response, error in
            if let error {
                print("I got error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            print("I got code: \(response.statusCode)")
            guard let data else { return }
            let dataText = String(bytes: data, encoding: .utf8) ?? "Can't get text from Data"
            print ("witch Data: \(dataText)")
        }
        task.resume()
    }

}
