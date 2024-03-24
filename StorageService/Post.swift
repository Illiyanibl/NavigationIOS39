//
//  Post.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 1.10.23.
//

//import Foundation
public struct Post {
    public var title: String
    public var text: String
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int = 0
    public var views: Int = 0
    public init(title: String = "NoTitle", text: String = "Some Text" , author: String, description: String, image: String) {
        self.title = title
        self.text = text
        self.author = author
        self.description = description
        self.image = image
    }
   public static func createPost() -> [Post] {
        let posts = [
            Post(author: "Вадим Макаренко",
                 description: "Владельцы новых Apple Watch жалуются на мерцающие экраны. Такое уже было",
                 image: "1"),
            Post(author: "Вадим Макаренко",
                 description: "Chery показала автомобиль с рекордно низким аэродинамическим сопротивлением",
                 image: "2"),
            Post(author: "Валентин Карузов",
                 description: "Assassin’s Creed Nexus для VR смогла приятно удивить прессу [ВИДЕО]",
                 image: "3"),
            Post(author: "Алексей Козачинский",
                 description: "В РФ подешевели старые iPhone. Насколько? После релиза линейки iPhone 15 стоимость предыдущих «яблочных» устройств заметно снизилась. Так, одна из самых популярных моделей — iPhone SE (2022) — подешевела в среднем на 20 тысяч рублей. Выясняем, как изменились цены на другие поколения гаджетов, согласно данным «Яндекс Маркета».",
                 image: "4"),]
        return posts
    }
}
