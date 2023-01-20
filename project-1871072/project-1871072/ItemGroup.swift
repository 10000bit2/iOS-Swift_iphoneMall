//
//  ItemGroup.swift
//  project-1871072
//
//  Created by 10000bit on 2021/05/20.
//

import Foundation

class ItemGroup: NSObject{
    var items = [Item]()
    override init(){
        super.init()
    }
    func testData(){
        for _ in 0...10{
            items.append(Item(random: true))
        }
    }
    func count() -> Int{
        return items.count
    }
    func addItem(item:Item){
        items.append(item)
    }
    func modifyItem(item:Item, index:Int){
        items[index] = item
    }
    func removeItem(index: Int){
        items.remove(at: index)
    }
}
