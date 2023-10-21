//
//  ProfileViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit
class ProfileViewController: UIViewController {

    private let posts = Post.createPost()

    lazy var  postTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Profile"
        view.addSubviews([postTable])
        setupConstraints()
    }
   // override func viewWillLayoutSubviews() {}
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
    

           //не стал делать высоту 220 - в ProfileHeaderView высота view связана с bottomAnchor кнопки Show status 
            postTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

        ])
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()

            return header }
        else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        PostTableViewCell.identifier, for: indexPath) as!  PostTableViewCell
        cell.setupSell(post: posts[indexPath.row])
        return cell
    }
    

}
