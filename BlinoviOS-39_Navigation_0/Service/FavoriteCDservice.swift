//
//  FavoriteCDservice.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 22.02.24.
//

import Foundation
import StorageService

protocol IFavoriteCDService {
    func addPost( _ post : Post)
    func fetchFavoritePost() -> [Post]
}

final class FavoriteCDService: IFavoriteCDService {
    var cdService: ICoreDataService
    init(cdService: ICoreDataService) {
        self.cdService = cdService
    }

    private func fetchFavoritePostModel() -> [FavoritePostModel]{
        let favoritePost: [FavoritePostModel]
        let request = FavoritePostModel.fetchRequest()
        do {
            favoritePost = try cdService.viewContext.fetch(request)
        } catch {
            favoritePost = []
            print(error.localizedDescription)
        }
        return favoritePost
    }

    func fetchFavoritePost() -> [Post] {
        var favoritePost: [Post] = []
        fetchFavoritePostModel().forEach() {
            var post = Post(author: $0.author ?? "nil",
                            description: $0.post ?? "nil",
                            image: $0.image ?? "nil")
            post.likes = Int($0.likes)
            post.views = Int($0.views)
            favoritePost.append(post)
        }
        return favoritePost
    }

    private func isNewPost(_ post : Post) -> Bool {
        var isNew = true
        fetchFavoritePostModel().forEach(){
            if $0.post == post.description { isNew = false}
        }
        return isNew
    }

    func addPost( _ post : Post){
        guard isNewPost(post) else { return }
        let addNewPost =  FavoritePostModel(context: cdService.viewContext)
        addNewPost.author = post.author
        addNewPost.image = post.image
        addNewPost.post = post.description
        let likes: Int64 = Int64(post.likes)
        let views: Int64 = Int64(post.views)
        addNewPost.views = views
        addNewPost.likes = likes

        do {
            try cdService.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
