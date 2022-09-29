//
//  DetailRouter.swift
//  prueba-coppel
//
//  Created Pedro Soriano on 28/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailRouter: DetailWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(id: Int?, movie: Bool?) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailViewController(nibName: nil, bundle: nil)
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.id = id
        view.TypeMovie = movie
        return view
    }
}