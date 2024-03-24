//
//  FavoriteView.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 21.02.24.
//

import UIKit
import StorageService
protocol IFavoriteView: AnyObject {}
final class FavoriteView : UIViewController, IFavoriteView {
    var favoriteService: IFavoriteCDService?
    var favoriteAction : ((FavoriteActionCases) -> Void)?
    var favoriteList : [Post] = []

    private var posts: [Post] = Post.createPost()
    lazy var  postTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    init(favoriteService: IFavoriteCDService?) {
        self.favoriteService = favoriteService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints(safeArea: view.safeAreaLayoutGuide)
    }

    override func viewWillAppear(_ animated: Bool){
        favoriteList = favoriteService?.fetchFavoritePost() ?? []
        postTable.reloadData()
        super.viewWillAppear(animated)
    }

    func setupView(){
        view.addSubview(postTable)

    }
    private func setupConstraints(safeArea: UILayoutGuide){
        NSLayoutConstraint.activate([
            postTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            postTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            postTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            postTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
}
extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PostTableViewCell.identifier, for: indexPath) as!  PostTableViewCell
        cell.setupSell(post: favoriteList[indexPath.row])
            return cell
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteList.count
    }
}

