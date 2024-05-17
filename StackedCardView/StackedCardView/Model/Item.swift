//
//  Item.swift
//  StackedCardView
//
//  Created by Jason on 2024/5/17.
//

import SwiftUI

struct Item: Identifiable {
    var id: UUID = .init()
    var logo: String
    var title: String
    var description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
}


var items: [Item] = [
    Item(logo: "Wechat", title: "Wechat"),
    Item(logo: "QQ", title: "QQ"),
    Item(logo: "Sina", title: "Sina"),
    Item(logo: "Apple", title: "Apple"),
    Item(logo: "Google", title: "Google"),
    Item(logo: "Alipay", title: "Alipay"),
    Item(logo: "Taobao", title: "Taobao"),
    Item(logo: "Dingding", title: "Dingding"),
    Item(logo: "Tiktok", title: "Tiktok"),
]
