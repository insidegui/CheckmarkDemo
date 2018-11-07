//
//  AnimationView.swift
//  CheckmarkDemo
//
//  Created by Guilherme Rambo on 07/11/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import UIKit

class AnimationView: UIView {

    let animationLayer: CALayer

    init(archive: AnimationArchive) {
        animationLayer = archive.rootLayer

        super.init(frame: .zero)

        stop()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(0)

        installAnimationLayerIfNeeded()
        layoutAnimationLayer()

        CATransaction.commit()
    }

    func stop() {
        animationLayer.timeOffset = 0
        animationLayer.speed = 0
    }

    func play() {
        animationLayer.speed = 1
        animationLayer.beginTime = CACurrentMediaTime()
    }

    private func installAnimationLayerIfNeeded() {
        guard animationLayer.superlayer == nil else { return }

        animationLayer.isGeometryFlipped = false
        layer.addSublayer(animationLayer)
    }

    private func layoutAnimationLayer() {
        let layerWidth = animationLayer.bounds.width
        let layerHeight = animationLayer.bounds.height

        let aspectWidth  = bounds.width / layerWidth
        let aspectHeight = bounds.height / layerHeight

        let fitRatio = min(aspectWidth, aspectHeight)
        animationLayer.transform = transform(for: fitRatio, contentSize: animationLayer.bounds.size)
    }

    private func transform(for ratio: CGFloat, contentSize: CGSize) -> CATransform3D {
        let scale = CATransform3DMakeScale(ratio, ratio, 1)

        let tx = (bounds.width - (contentSize.width * ratio))/2.0
        let ty = (bounds.height - (contentSize.height * ratio))/2.0

        let translation = CATransform3DMakeTranslation(tx, ty, 0)

        return CATransform3DConcat(scale, translation)
    }

}
