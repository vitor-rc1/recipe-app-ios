//
//  RadioButton.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/06/22.
//

import UIKit

protocol RadioButtonsListDelegate: AnyObject {
    func radioSelected(title: String?)
}

final class RadioButtonsList: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var radioButtonsTitles: [String] = []
    private var radioButtons: [UIButton] = []

    weak var delegate: RadioButtonsListDelegate?

    convenience init(titles: [String]) {
        self.init(frame: .zero)

        radioButtonsTitles = titles

        setupView()
        setupList()
    }

    func setupList() {
        for radioButtonTitle in radioButtonsTitles {
            let radioButton = setupRadio(title: radioButtonTitle)
            stackView.addArrangedSubview(radioButton)
            radioButtons.append(radioButton)
        }
    }

    private func setupRadio(title: String = String()) -> UIButton {
        let radioButton = UIButton(frame: .zero)
        radioButton.setTitleColor(.systemGray, for: .normal)
        radioButton.setTitle(title, for: .normal)
        radioButton.setImage(UIImage(named: "radio-empty"), for: .normal)
        radioButton.setImage(UIImage(named: "radio-filled"), for: .highlighted)
        radioButton.setImage(UIImage(named: "radio-filled"), for: .selected)
        radioButton.titleEdgeInsets.left = 5
        radioButton.contentHorizontalAlignment = .left
        radioButton.titleLabel?.font = .systemFont(ofSize: 15)
        radioButton.addTarget(self, action: #selector(selectRadio), for: .touchUpInside)
        return radioButton
    }

    @objc func selectRadio(_ button: UIButton) {
        cleanRadiosState()
        button.setImage(UIImage(named: "radio-filled"), for: .normal)
        delegate?.radioSelected(title: button.titleLabel?.text)
    }

    func cleanRadiosState() {
        for radioButton in radioButtons {
            radioButton.setImage(UIImage(named: "radio-empty"), for: .normal)
        }
    }
}

extension RadioButtonsList: ViewCode {

    func buildViewHierarch() {
        addSubview(stackView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func additionalConfiguration() {}

}
