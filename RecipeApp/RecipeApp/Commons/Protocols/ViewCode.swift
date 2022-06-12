//
//  File.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 06/06/22.
//

import Foundation

protocol ViewCode {
    func buildViewHierarch()
    func setUpConstraints()
    func additionalConfiguration()
}

extension ViewCode {
    func setUp() {
        buildViewHierarch()
        setUpConstraints()
        additionalConfiguration()
    }

    func buildViewHierarch() {}
    func setUpConstraints() {}
    func additionalConfiguration() {}
}
