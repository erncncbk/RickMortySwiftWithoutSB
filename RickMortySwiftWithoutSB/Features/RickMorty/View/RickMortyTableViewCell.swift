//
//  RickMortyTableViewCell.swift
//  RickMortySwiftWithoutSB
//
//  Created by Erencan on 9.06.2022.
//

import UIKit
import SnapKit
import AlamofireImage

class RickMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title : UILabel = UILabel()
    private let customDescription : UILabel = UILabel()

    private let randomImage: String = "https://picsum.photos/id/237/200/300"
    
    enum Identifier: String{
        case custom = "erncncbk"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 20)
        title.textColor = .black
        customDescription.textColor = .black
        
        customDescription.font = .italicSystemFont(ofSize: 10)

        customImage.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.top).offset(10)
            make.right.left.equalTo(contentView)
        }
       
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model:Result)  {
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string:model.image ?? randomImage) ??  URL(string:randomImage)!)
    }
    
}
