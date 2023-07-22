//
//  TypeAlias.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

public typealias ResultCompletionHandler<T, E: Error> = (Result<T, E>) -> Void
