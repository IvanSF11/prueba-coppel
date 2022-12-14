//
//  HomeRouter.swift
//  prueba-coppel
//
//  Created Pedro Soriano on 27/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomeRouter: HomeWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HomeViewController(nibName: nil, bundle: nil)
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToDetailMovies(id: Int?, movie: Bool?){
        let vc = DetailRouter.createModule(id: id, movie: movie)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToDetailTV(id: Int?, movie: Bool?){
        let vc = DetailRouter.createModule(id: id, movie: movie)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToProfile(){
        let vc = ProfileRouter.createModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

