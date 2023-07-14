//
//  CarouselViewModel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/15.
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.

import Foundation
import Combine
// 임시 ViewModel
final class CarouselViewModel: ObservableObject {
    
    // Properties
    @Published private(set) var stateModel: UIStateModel = UIStateModel()
    @Published private(set) var activeCard: Int = 0
    private var cancellables: [AnyCancellable] = []
    
    // Lifecycle
    init() {
        self.stateModel.$activeCard.sink { completion in
            switch completion {
            case let .failure(error):
                print("finished with error: ", error.localizedDescription)
            case .finished:
                print("finished")
            }
        } receiveValue: { [weak self] activeCard in
            self?.activeCardUpdate(for: activeCard)
        }.store(in: &cancellables)
    }
    
    // Helper
    private func activeCardUpdate(for activeCard: Int) {
        self.activeCard = activeCard
    }
}
