//
//  MeProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol MeModuleInput {
	var moduleOutput: MeModuleOutput? { get }
}

protocol MeModuleOutput: class {
}

protocol MeViewInput: class {
}

protocol MeViewOutput: class {
}

protocol MeInteractorInput: class {
}

protocol MeInteractorOutput: class {
}

protocol MeRouterInput: class {
}
