//
//  UiView+Constraints.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 28/09/22.
//

import UIKit

extension UIView {
    func addSubviewAndConstraints(_ view: UIView, margin: CGFloat = 0.0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margin),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin)
        ])
    }
    
    func addSubviewAndContraintToSafeArea(_ view: UIView, margin: CGFloat = 0.0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: margins.topAnchor, constant: margin),
            view.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: margin),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: margin),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: margin)
        ])
    }
}
