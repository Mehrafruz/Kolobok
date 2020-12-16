//
//  SearchProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol SearchModuleInput {
	var moduleOutput: SearchModuleOutput? { get }
}

protocol SearchModuleOutput: class {
}

protocol SearchViewInput: class {
}

protocol SearchViewOutput: class {
}

protocol SearchInteractorInput: class {
}

protocol SearchInteractorOutput: class {
}

protocol SearchRouterInput: class {
}
