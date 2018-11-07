//
//  AnimationArchive.swift
//  CheckmarkDemo
//
//  Created by Guilherme Rambo on 07/11/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import UIKit

final class AnimationArchive {

    let rootLayer: CALayer

    enum LoadError: Error {
        case assetNotFound
        case invalidFormat
        case missingRootLayer
    }

    init(assetNamed name: String, bundle: Bundle = .main) throws {
        let data: Data

        if let catalogData = NSDataAsset(name: name, bundle: bundle)?.data {
            data = catalogData
        } else {
            guard let url = bundle.url(forResource: name, withExtension: "caar") else {
                throw LoadError.assetNotFound
            }

            data = try Data(contentsOf: url)
        }

        guard let caar = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Any] else {
            throw LoadError.invalidFormat
        }

        guard let layer = caar["rootLayer"] as? CALayer else {
            throw LoadError.missingRootLayer
        }

        self.rootLayer = layer
    }

}
