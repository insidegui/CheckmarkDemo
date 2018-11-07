//
//  StepController.swift
//  CheckmarkDemo
//
//  Created by Guilherme Rambo on 07/11/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import UIKit
import os.log

final class StepController: UIViewController {

    private let log = OSLog(subsystem: "codes.rambo.CheckmarkDemo", category: "StepController")

    var buttonTitle: String? {
        get {
            return actionButton.title(for: .normal)
        }
        set {
            actionButton.setTitle(newValue, for: .normal)
        }
    }

    var buttonAction: (() -> Void)?

    private lazy var actionButton: UIButton = {
        let b = UIButton(type: .system)

        b.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false

        return b
    }()

    @objc private func buttonTapped() {
        buttonAction?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        installButton()
    }

    private func installButton() {
        view.addSubview(actionButton)

        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            actionButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    // MARK: - Success animation

    private lazy var feedbackGenerator = UINotificationFeedbackGenerator()

    func performSuccessAnimation() {
        feedbackGenerator.notificationOccurred(.success)
        actionButton.removeFromSuperview()

        loadAndShowCheckmarkAnimation()
    }

    private var checkmarkView: AnimationView?

    private func loadAndShowCheckmarkAnimation() {
        do {
            let archive = try AnimationArchive(assetNamed: "Checkmark")

            checkmarkView = AnimationView(archive: archive)
            checkmarkView?.translatesAutoresizingMaskIntoConstraints = false

            showCheckmarkAnimation()
        } catch {
            os_log("Failed to load success animation: %{public}@", log: self.log, type: .error, String(describing: error))
        }
    }

    private func showCheckmarkAnimation() {
        guard let checkmarkView = checkmarkView else { return }

        view.addSubview(checkmarkView)

        NSLayoutConstraint.activate([
            checkmarkView.widthAnchor.constraint(equalToConstant: 120),
            checkmarkView.heightAnchor.constraint(equalToConstant: 120),
            checkmarkView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkmarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        checkmarkView.play()
    }

}

