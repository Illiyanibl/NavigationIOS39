//
//  ProfileViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit
import StorageService


final class ProfileViewController: UIViewController {
    var favoriteService: IFavoriteCDService?
    let zeroFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    private let posts = Post.createPost()
    private var user: User?
    var profileHeaderView = ProfileHeaderView()
    var profileAction : ((ProfileVCActionCases) -> Void)?
    
    lazy var  postTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return table
    }()
    
    lazy var avatar: UIView = {
        let view = UIView()
        view.layer.contents = profileHeaderView.avatarView.image?.cgImage
        view.layer.cornerRadius = profileHeaderView.avatarSize / 2
        view.layer.masksToBounds = true
        return view
    }()
    lazy var bgAvatar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    lazy var btCloseView: UIButton = {
        let button = UIButton(type: .close)
        button.alpha = 0
        button.addTarget(self, action: #selector(tapCloseAvatar), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Main
    init(favoriteService: IFavoriteCDService?) {
        self.favoriteService = favoriteService
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user else {
            profileAction?(.authError)
            return
        }
        setUser(user: user)
        setupView()
        setupConstraints()
    }
    private func setupView(){
        //view.backgroundColor = .lightGray
#if DEBUG
        view.backgroundColor = .yellow
#else
        view.backgroundColor = .green
#endif
        title = NSLocalizedString("Profile", comment: "")
        view.addSubviews([postTable])
        
    }
    
    private func setUser(user: User){
        profileHeaderView.setUser(user: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    // override func viewWillLayoutSubviews() {}
    
    // MARK: - Avatar Animation
    
    lazy var getAvatarFrame = CGRect.zero
    lazy var getAvatarCenter = CGPoint.zero
    
    func getUser(user: User){
        self.user = user
        setUser(user: user)
    }
    
    func tapAvatar(avatarFrame: CGRect, avatarCenter:  CGPoint){
        view.addSubviews([bgAvatar,avatar, btCloseView])
        getAvatarFrame = avatarFrame
        avatar.frame = getAvatarFrame
        getAvatarCenter = avatarCenter
        setupShowingAvatarConstraints()
        view.needsUpdateConstraints()
        view.layoutIfNeeded()
        avatarAnimationOpen()
    }
    
    @objc func tapCloseAvatar(){
        avatarAnimationClose()
    }
    
    func avatarClosed(){
        self.btCloseView.removeFromSuperview()
        self.bgAvatar.removeFromSuperview()
        self.avatar.removeFromSuperview()
    }
    
    func avatarAnimationClose(){
        let avatarFrame = getAvatarFrame
        let avatarCenter = getAvatarCenter
        let btAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseView.alpha = 0
        }
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.avatar.frame = avatarFrame
            self.avatar.center = CGPoint(x: avatarCenter.x, y: avatarCenter.y)
            self.avatar.layer.cornerRadius = self.profileHeaderView.avatarSize / 2
            self.bgAvatar.alpha = 0.0
        }
        
        btAnimator.addCompletion { _ in
            animator.startAnimation(afterDelay: 0.0)}
        animator.addCompletion{ _ in
            self.avatarClosed()}
        btAnimator.startAnimation(afterDelay: 0.0)
    }
    
    func avatarAnimationOpen(){
        let finalCenter = self.view.center
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.avatar.frame = CGRect(x: 6, y: 6, width: self.bgAvatar.frame.width - 12, height: self.bgAvatar.frame.width - 12)
            self.avatar.center = CGPoint(x: finalCenter.x, y: finalCenter.y)
            self.avatar.layer.cornerRadius = 0
            self.bgAvatar.alpha = 0.5
        }
        
        let btAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseView.alpha = 1
        }
        
        animator.addCompletion {_ in
            btAnimator.startAnimation(afterDelay: 0.0)
        }
        animator.startAnimation(afterDelay: 0.0)
    }
    // MARK: - Constraints
    
    
    private func setupShowingAvatarConstraints(){
        NSLayoutConstraint.activate([
            bgAvatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bgAvatar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bgAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgAvatar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            btCloseView.trailingAnchor.constraint(equalTo: bgAvatar.trailingAnchor, constant: -6),
            btCloseView.topAnchor.constraint(equalTo: bgAvatar.topAnchor, constant: 6),
        ])
    }
    
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
            profileHeaderView.avatarTapCallBack = { [weak self] in
                guard let self = self else { return}
                let avatarFrame = tableView.convert(self.profileHeaderView.avatarView.frame, to: self.view)
                let avatarCenter = tableView.convert(self.profileHeaderView.avatarView.center, to: self.view)
                self.tapAvatar(avatarFrame: avatarFrame, avatarCenter: avatarCenter)
            }
            let header = profileHeaderView
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PhotosTableViewCell.identifier, for: indexPath) as!  PhotosTableViewCell
            cell.callBackTapArrow = profileAction
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PostTableViewCell.identifier, for: indexPath) as!  PostTableViewCell
            cell.setupSell(post: posts[indexPath.row])
            cell.doubleTapAction = { [weak self] in
                guard let self else { return }
                self.favoriteService?.addPost(posts[indexPath.row])
            }
            return cell
        }
    }
}
