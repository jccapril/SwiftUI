//
//  Item.swift
//  PinterestGridAnimation
//
//  Created by Jason on 2024/5/20.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    private(set) var id: UUID = .init()
    var title: String
    var image: UIImage?
}


var smapleImages: [Item] = [
    Item(title: "在森林里的一条通路的照片", image: UIImage(named: "Pic1")),
    Item(title: "Tugce Nil", image: UIImage(named: "Pic2")),
    Item(title: "空旷的公路，俯瞰山在黑暗的天空下", image: UIImage(named: "Pic3")),
    Item(title: "瓮与石", image: UIImage(named: "Pic4")),
    Item(title: "白天流的照片", image: UIImage(named: "Pic5")),
    Item(title: "涂鸦墙与脚手架", image: UIImage(named: "Pic6")),
    Item(title: "山和湖", image: UIImage(named: "Pic7")),
    Item(title: "沿松树的途径", image: UIImage(named: "Pic8")),
]
