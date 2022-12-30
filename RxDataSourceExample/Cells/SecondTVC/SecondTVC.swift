//
//  SecondTVC.swift
//  RxDataSourceExample
//
//  Created by Engineer on 30/12/22.
//

import UIKit

final class SecondTVC: UITableViewCell {

    private let labelDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var viewModel: SecondCellViewModel! {
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
        contentView.addSubview(labelDescription)
        selectionStyle = .none
        NSLayoutConstraint.activate([
            labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            labelDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            labelDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            labelDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateViewValues(withViewModel viewModel: SecondCellViewModel) {
        labelDescription.text = viewModel.descriptionText
    }
}
