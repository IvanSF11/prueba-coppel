//
//  HomePresenter.swift
//  prueba-coppel
//
//  Created Pedro Soriano on 27/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol {

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func fetchMovies(type: typeMovies){
        interactor?.fetchMovies(type: type)
    }
    
    func responseMovies(data: MoviesResponse){
        view?.responseMovies(data: data)
    }
    
    func fetchTV(type: typeTV){
        interactor?.fetchTV(type: type)
    }
    
    func responseTV(data: TVResponse){
        view?.responseTV(data: data)
    }
    
    func goToDetailMovies(id: Int?, movie: Bool?){
        router.goToDetailMovies(id: id, movie: movie)
    }
    
    func goToDetailTV(id: Int?, movie: Bool?){
        router.goToDetailTV(id: id, movie: movie)
    }
    
    func initDateBase(){
        interactor?.initDateBase()
    }
    
    func updateDatabase(values: [MoviesValue]){
        interactor?.updateDatabase(values: values)
    }
    
    func updateDatabase(_ value: MoviesValue){
        interactor?.updateDatabase(value)
    }
    
    func getDatabaseData() -> [MoviesValue]?{
        return interactor?.getDatabaseData()
    }
    
    func goToProfile(){
        router.goToProfile()
    }
    
    func deleteRowData(_ id: Int){
        interactor?.deleteRowData(id)
    }
    
    func showError(title: String){
        view?.showError(title: title)
    }
}
