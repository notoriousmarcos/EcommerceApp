//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 05/08/23.
//

import Foundation

public class ShopCore {

  private let httpClient: HTTPClient

  public lazy var remoteAuthenticationUseCase: AuthenticationUseCase = RemoteAuthenticationUseCase(client: remoteAuthenticationClient)
  public lazy var remoteCreateCartUseCase: CreateCartUseCase = RemoteCreateCartUseCase(client: remoteCreateCartClient)
  public lazy var remoteGetCurrentCartUseCase: GetCurrentCartUseCase = RemoteGetCurrentCartUseCase(client: remoteGetCurrentCartClient)
  public lazy var remoteGetProductUseCase: GetProductUseCase = RemoteGetProductUseCase(client: remoteGetProductClient)
  public lazy var remoteGetProductsUseCase: GetProductsUseCase = RemoteGetProductsUseCase(client: remoteGetProductsClient)
  public lazy var remoteGetUserUseCase: GetUserUseCase = RemoteGetUserUseCase(client: remoteGetUserClient)
  public lazy var remoteUpdateCartUseCase: UpdateCartUseCase = RemoteUpdateCartUseCase(client: remoteUpdateCartClient)

  public lazy var localAddProductToCartUseCase: AddProductToCartUseCase = LocalAddProductToCartUseCase()
  public lazy var localUpdateProductInCartUseCase: UpdateProductInCartUseCase = LocalUpdateProductInCartUseCase()
  public lazy var localRemoveProductInCartUseCase: RemoveProductInCartUseCase = LocalRemoveProductInCartUseCase()


  public init(httpClient: HTTPClient = NativeHTTPClient()) {
    self.httpClient = httpClient
  }

  private lazy var remoteAuthenticationClient = RemoteAuthenticationClient(client: httpClient)
  private lazy var remoteCreateCartClient = RemoteCreateCartClient(client: httpClient)
  private lazy var remoteGetCurrentCartClient = RemoteGetCurrentCartClient(client: httpClient)
  private lazy var remoteGetProductClient = RemoteGetProductClient(client: httpClient)
  private lazy var remoteGetProductsClient = RemoteGetProductsClient(client: httpClient)
  private lazy var remoteGetUserClient = RemoteGetUserClient(client: httpClient)
  private lazy var remoteUpdateCartClient = RemoteUpdateCartClient(client: httpClient)

}
