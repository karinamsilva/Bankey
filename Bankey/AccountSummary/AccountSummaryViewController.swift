import UIKit

class AccountSummaryViewController: UIViewController {
    
    var profile: Profile?
    var accounts: [Account] = []
    
    var accountCellViewModel: [AccountSummaryCell.ViewModel] = []
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    var isLoaded = false
    
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "welcome", name: "", date: Date())
    
    var tableView = UITableView()
    lazy var logoutButton: UIBarButtonItem = {
        let barbuttonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barbuttonItem.tintColor = .label
        return barbuttonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        setUpNavigationBar()
        setUpRefreshControl()
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = appColor
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setUpRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        configureTableCells(with: accounts)
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModel.isEmpty else { return UITableViewCell()}
        let account = accountCellViewModel[indexPath.row]
        
        if isLoaded {
            let cell =  tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseId, for: indexPath) as! SkeletonCell
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModel.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension AccountSummaryViewController {
    private func fetchData() {
        
        let group = DispatchGroup()
        
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            guard let profile = self.profile else { return }
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)

            self.isLoaded = true
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let viewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good Morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: viewModel)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModel = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }

}

// MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
}
