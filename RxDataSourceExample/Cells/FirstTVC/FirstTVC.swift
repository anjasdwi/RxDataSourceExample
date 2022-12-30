//
//  FirstTVC.swift
//  RxDataSourceExample
//
//  Created by Engineer on 30/12/22.
//

import UIKit

final class FirstTVC: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .gray
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var viewModel: FirstCellViewModel! {
        didSet {
            updateViewValues(withViewModel: viewModel)
        }
    }

    override init(
        style: UITableViewCell.CellStyle = .default,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubview(label)
        selectionStyle = .none
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateViewValues(withViewModel viewModel: FirstCellViewModel) {
        label.text = viewModel.title
    }
}
