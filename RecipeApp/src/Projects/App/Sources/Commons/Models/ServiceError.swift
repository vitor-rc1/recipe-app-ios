//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

public enum ServiceError: Error, Equatable {
    case invalidURL(String?)
    case decodeFail(String?)
    case network(String?)
}
