//
//  LoginProtocols.swift
//  prueba-coppel
//
//  Created Pedro Soriano on 27/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol LoginWireframeProtocol: AnyObject {
    func goToHome()
}
//MARK: Presenter -
protocol LoginPresenterProtocol: AnyObject {
    func goToHome()
}

//MARK: Interactor -
protocol LoginInteractorProtocol: AnyObject {

  var presenter: LoginPresenterProtocol?  { get set }
}

//MARK: View -
protocol LoginViewProtocol: AnyObject {

  var presenter: LoginPresenterProtocol?  { get set }
}
