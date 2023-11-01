//
//  ProfileViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit

final class ProfileViewController: UIViewController {


    let zeroFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    private let posts = Post.createPost()

    lazy var  postTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return table
    }()

    // MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        title = "Profile"
        view.addSubviews([postTable])
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    // override func viewWillLayoutSubviews() {}

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
// MARK: - Extension

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()
            return header }
        else {
            return UIView(frame: zeroFrame)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 }
        else {
            return posts.count
        }
    }

    func mapCalBackTapArrow( cell: PhotosTableViewCell) -> PhotosTableViewCell{
        cell.callBackTapArrow = { [weak self] in
            guard let self = self else { return}
            self.navigationController?.pushViewController(PhotosViewController(), animated: false)}
        return  cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PhotosTableViewCell.identifier, for: indexPath) as!  PhotosTableViewCell
            return mapCalBackTapArrow(cell: cell)
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PostTableViewCell.identifier, for: indexPath) as!  PostTableViewCell
            cell.setupSell(post: posts[indexPath.row])
            return cell
        }
    }
}
