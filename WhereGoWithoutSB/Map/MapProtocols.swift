//
//  MapProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 12.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol MapModuleInput {
	var moduleOutput: MapModuleOutput? { get }
}

protocol MapModuleOutput: class {
}

protocol MapViewInput: class {
}

protocol MapViewOutput: class {
}

protocol MapInteractorInput: class {
}

protocol MapInteractorOutput: class {
}

protocol MapRouterInput: class {
}
