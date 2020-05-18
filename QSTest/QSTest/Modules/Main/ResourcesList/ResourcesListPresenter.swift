//
//  ResourcesListPresenter.swift
//  QSTest
//
//  Created by Denys Volkov on 2020-05-18.
//  Copyright © 2020 quickseries. All rights reserved.
//

import Foundation

protocol ResourcesListPresenterDelegate: AnyObject {
    func presenter(_ presenter: ResourcesListPresenterProtocol, didSelect restaurant: Restaurant)
    func presenter(_ presenter: ResourcesListPresenterProtocol, didSelect vacationSpot: VacationSpot)
}

protocol ResourcesListPresenterProtocol: BasePresenterProtocol {
    func onSelectResource(with id: String)
}

enum ResourcesState {
    case restaurants(_ restaurant: Restaurants)
    case vacationSpots(_ vacationSpots: VacationSpots)
}


class ResourcesPresenter {
    private weak var delegate: ResourcesListPresenterDelegate?
    private weak var controller: ResourcesListControllerProtocol?
    private var state: ResourcesState
    
    init(controller: ResourcesListControllerProtocol,
         delegate: ResourcesListPresenterDelegate,
         state: ResourcesState) {
        self.controller = controller
        self.delegate = delegate
        self.state = state
    }
    
    private func update(with state: ResourcesState) {
        switch state {
        case let .restaurants(restaurants):
            let models = ResourcesListFormatter.convert(restaurants)
            controller?.show(rows: models)
        case let .vacationSpots(vacationSpots):
            let models = ResourcesListFormatter.convert(vacationSpots)
            controller?.show(rows: models)
        }
    }
}

extension ResourcesPresenter: ResourcesListPresenterProtocol {
    func onViewDidLoad() {
        update(with: state)
    }
    
    func onSelectResource(with id: String) {
        switch state {
        case let .restaurants(restaurants):
            guard let model = restaurants.first(where: { $0.eid == id }) else { return }
            delegate?.presenter(self, didSelect: model)
        case let .vacationSpots(vacationSpots):
            guard let model = vacationSpots.first(where: { $0.eid == id }) else { return }
            delegate?.presenter(self, didSelect: model)
        }
    }
}
