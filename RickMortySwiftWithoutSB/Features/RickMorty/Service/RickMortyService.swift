//
//  RickMortyService.swift
//  RickMortySwiftWithoutSB
//
//  Created by Erencan on 7.06.2022.
//

import Alamofire

enum RickMortyServiceEndpoint: String{
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func  characterPath() -> String{
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}


protocol IRickMortyService {
    func fetchAllDatas(response:@escaping ([Result]?) -> Void)
}

struct RickMortyService: IRickMortyService{
    func fetchAllDatas(response:@escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndpoint.characterPath()).responseDecodable(of: RickMortyModel.self) { model in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
    
    
}
