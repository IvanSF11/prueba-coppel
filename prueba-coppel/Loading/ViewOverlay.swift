//
//  ViewOverlay.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 28/09/22.
//

import UIKit
import Lottie

final class ViewOverlay: UIView {
    
    private let lottieOverlay = UIView()
    private let lottie = GenericLottie.getGenericLottie()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hide()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startLoadingView() {
        show()
        showLoadingView()
        lottie.play(fromProgress: .zero, toProgress: .infinity, loopMode: .repeat(20.0))
    }
    
    func finishLoadingView() {
        lottie.stop()
        lottieOverlay.removeFromSuperview()
        hide()
    }
    
    func hide() {
        isUserInteractionEnabled = false
        isHidden = true
    }
    
    func show() {
        isUserInteractionEnabled = true
        isHidden = false
    }
    
    private func showLoadingView() {
        isUserInteractionEnabled = true
        isHidden = false
        lottie.backgroundColor = .lightGray
        lottieOverlay.addSubviewAndConstraints(lottie)
        addSubviewAndConstraints(lottieOverlay)
    }
}

public class GenericLottie {
    public static func getGenericLottie() -> AnimationView {
        let animation = AnimationView(name: "loading", bundle: .local)
        
        return animation
    }
}

extension Bundle {
    static let local: Bundle = Bundle.init(for: GenericLottie.self)
}
