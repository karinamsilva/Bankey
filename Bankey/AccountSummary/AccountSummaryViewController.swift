import UIKit

class AccountSummaryViewController: UIViewController {
    
    var profile: Profile?
    var accounts: [Account] = []
    
    var accountCellViewModel: [AccountSummaryCell.ViewModel] = []
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
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
        fetchData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = appColor
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
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
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else { return UITableViewCell()}
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModel[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(accounts[indexPath.row])
    }
}
extension AccountSummaryViewController {
    private func fetchData() {
        
        let group = DispatchGroup()
        group.enter()
        
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                    self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
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
}
