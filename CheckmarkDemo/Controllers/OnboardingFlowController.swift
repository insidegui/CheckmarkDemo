//
//  OnboardingFlowController.swift
//  CheckmarkDemo
//
//  Created by Guilherme Rambo on 07/11/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import UIKit

final class OnboardingFlowController: UIViewController {

    private lazy var currentStepController: StepController = {
        return makeStepController()
    }()

    private lazy var ownedNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: currentStepController)
    }()

    private let stepCount = 3
    private var currentStep = 1

    private var titleForCurrentStep: String {
        return "Step \(currentStep)"
    }

    private func makeStepController() -> StepController {
        let c = StepController()

        c.title = titleForCurrentStep
        c.buttonTitle = "Next"
        c.buttonAction = { [weak self] in
            self?.step()
        }

        return c
    }

    private func makeFinalController() -> StepController {
        let c = StepController()

        c.title = titleForCurrentStep
        c.buttonTitle = "Finish"
        c.buttonAction = { [weak self] in
            self?.finish()
        }

        return c
    }

    private func step() {
        currentStep += 1

        let nextController: StepController

        if currentStep >= stepCount {
            nextController = makeFinalController()
        } else {
            nextController = makeStepController()
        }

        ownedNavigationController.pushViewController(nextController, animated: true)

        currentStepController = nextController
    }

    private func finish() {
        ownedNavigationController.setViewControllers([currentStepController], animated: false)
        currentStepController.performSuccessAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        installNavigationController()
    }

    private func installNavigationController() {
        ownedNavigationController.view.frame = view.bounds
        ownedNavigationController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(ownedNavigationController.view)
        addChild(ownedNavigationController)
        ownedNavigationController.didMove(toParent: self)
    }

}
