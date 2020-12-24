//
//  MePresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class MePresenter {
	weak var view: MeViewInput?
    weak var moduleOutput: MeModuleOutput?

	private let router: MeRouterInput
	private let interactor: MeInteractorInput

    init(router: MeRouterInput, interactor: MeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MePresenter: MeModuleInput {
}

extension MePresenter: MeViewOutput {
}

extension MePresenter: MeInteractorOutput {
}
