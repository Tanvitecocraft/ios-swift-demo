//
//  ThemeButton.swift
//
//

import UIKit
import Foundation

class ThemeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.setTitleColor(.fontWhiteColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.backgroundColor = .appThemeColor
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = false
    }
}
