//
//  NetworkService.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

fileprivate typealias NetworkResponseCompletion = (_ data: Data?,
                                                   _ response: URLResponse?,
                                                   _ error: Error?) -> ()

typealias ResponseCompletion<T: Decodable> = (_ data: T?, _ error: Error?) -> ()

// Default network service instances
extension NetworkService {
    
    static let `default`: NetworkService = .init(with: .base)
}

// Entry point for all requests
class NetworkService {
    
    private let session: URLSession
    private let configuration: NetworkServiceConfiguration
    
    // MARK: - Service Initializer
    
    init(with configuration: NetworkServiceConfiguration) {
        
        self.configuration = configuration
        
        session = URLSession(configuration: configuration.sessionConfiguration)
    }
    
    // MARK: - Service Interface
    
    @discardableResult
    func request<EndpointType: Endpoint>(_ endpoint: EndpointType,
                                         validator: NetworkResponseValidator = BaseNetworkResponseValidator(),
                                         completion: @escaping ResponseCompletion<EndpointType.ResponseType>)
        -> URLSessionTask? {

        do {
            let task = try buildTask(from: endpoint) { [weak self] data, response, error in
                self?.processResponse(response,
                                      data: data,
                                      error: error,
                                      validator: validator,
                                      completion: completion)
            }
            
            task.resume()
            
            return task
            
        } catch {
            completion(nil, error)
        }
        
        return nil
    }
    
    // MARK: - Private
    
    private func processResponse<T: Decodable>(_ response: URLResponse?,
                                               data: Data?,
                                               error: Error?,
                                               validator: NetworkResponseValidator,
                                               completion: @escaping ResponseCompletion<T>) {
        
        guard let response = response, let data = data else {
            completion(nil, error)
            return
        }
        
        do {
            try validator.validate(response)
            
            let object = try configuration.responseDecoder.decode(T.self, from: data)
            completion(object, nil)
            
        } catch {
            completion(nil, error)
        }
    }
    
    private func buildRequest<EndpointType: Endpoint>(from endpoint: EndpointType) throws -> URLRequest {
        
        let fullUrl = configuration.baseUrl.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: fullUrl)
        
        request.httpMethod = endpoint.method.rawValue
        
        switch endpoint.task {
        case let .request(body):
                        
            if let body = body {
                if endpoint.method == .get {
                    var components = URLComponents(url: fullUrl, resolvingAgainstBaseURL: false)
                    components?.queryItems = body.map { (key, value) in
                        .init(name: key, value: value as? String)
                    }
                    request.url = components?.url
                } else {
                    try configuration.parameterEncoder.encode(urlRequest: &request, with: body)
                }
            }
            
            if let headers = endpoint.headers {
                
                headers.forEach {
                    request.addValue($0.value, forHTTPHeaderField: $0.key)
                }
            }
        }
        
        return request
    }
    
    private func buildTask<EndpointType: Endpoint>(from endpoint: EndpointType,
                                                   completion: @escaping NetworkResponseCompletion) throws
        -> URLSessionTask {
        
        let request = try buildRequest(from: endpoint)

        switch endpoint.task {
        case .request:
            return session.dataTask(with: request, completionHandler: completion)
        }
    }
}
