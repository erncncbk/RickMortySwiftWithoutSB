//
//  RickMortyViewModel.swift
//  RickMortySwiftWithoutSB
//
//  Created by Erencan on 7.06.2022.
//

import Foundation

protocol IRickMortyViewModel{
    func fetchItems()
    func changeLoading()
    var rickMortyCharacters:[Result] {get set}
    var rickMortyService : IRickMortyService {get}
    
    var rickMortyOutput : RickMortyOutput? {get}
    
    func setDelegate (output:RickMortyOutput )

}

class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutput: RickMortyOutput?
        
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    
    var rickMortyCharacters: [Result] = []
    private var isLoading = false
    let rickMortyService: IRickMortyService
    
    init(){
        rickMortyService = RickMortyService()
    }
    
    
    func fetchItems() {
        changeLoading()
        rickMortyService.fetchAllDatas {[weak self] response in
            self?.changeLoading()
            self?.rickMortyCharacters = response ?? []
            self?.rickMortyOutput?.saveData(values: self?.rickMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
}
