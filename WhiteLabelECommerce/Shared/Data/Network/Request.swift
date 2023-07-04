//
//  Request.swift
//  WhiteLabelECommerce
//
//  Created by marcos.brito on 03/09/21.
//

import Foundation

protocol Request {
  var path: String { get }
  var method: HTTPMethod { get }
  var contentType: String { get }
  var params: [String: Any]? { get }
  var body: [String: Any]? { get }
  var headers: [String: String]? { get }
}

extension Request {
  private func requestBodyFrom(params: [String: Any]?) -> Data? {
    guard let params = params else { return nil }
    guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
      return nil
    }
    return httpBody
  }

  private func makeURLComponents(_ path: String, params: [String: Any]?) -> URL? {
    var urlComponents = URLComponents(url: Config.baseURL, resolvingAgainstBaseURL: true)
    urlComponents?.path = path
    if let params = params {
      urlComponents?.queryItems = params.map({ param in
        URLQueryItem(name: param.key, value: param.value as? String)
      })
    }
    return urlComponents?.url
  }

  func asURLRequest() -> URLRequest? {
    guard let finalURL = makeURLComponents(path, params: params) else {
      return nil
    }
    var request = URLRequest(url: finalURL)
    request.httpMethod = method.rawValue
    request.httpBody = requestBodyFrom(params: body)
    let defaultHeaders: [String: String] = [
      "Content-Type": contentType,
      "Accept": contentType
    ]
    request.allHTTPHeaderFields = defaultHeaders.merging(headers ?? [:], uniquingKeysWith: { first, _ in first })
    return request
  }
}
