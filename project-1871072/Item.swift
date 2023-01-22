//
//  Item.swift
//  project-1871072
//
//  Created by 10000bit on 2021/05/20.
//

import Foundation

class Item: NSObject{
    var name: String
    var user: String
    var price: String?
    
    init(name: String, user: String, price: String?){
        self.name = name
        self.user = user
        self.price = price
        super.init()
    }
}

extension Item{
    convenience init(random: Bool = false){
        if random == false {
            self.init(name:"", user:"", price: nil)
            return
        }
        let names = ["애플워치 스트랩","아이패드 케이스","아이폰 케이스", "20W 충전기 어댑터", "8핀 충전기", "맥북 키스킨"]
        let users = ["이승렬", "손흥민", "이광연", "이강인", "정성룡", "기성용"]
        let prices = ["12,000원", "15,000원", "20,000원", "18,000원", "25,000원", "13,000원"]
        
        var index = Int(arc4random_uniform(UInt32(names.count)))
        let name = names[index]
        
        index = Int(arc4random_uniform(UInt32(users.count)))
        let user = users[index]
        
        index = Int(arc4random_uniform(UInt32(prices.count)))
        let price = prices[index]
        
        self.init(name: name, user: user, price: price)
    }
}
