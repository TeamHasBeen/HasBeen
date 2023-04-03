import UIKit
import Nuke

class DetailCell: UITableViewCell {
    @IBOutlet weak var destinationDescription: UILabel!
    @IBOutlet weak var destinationImage: UIImageView!
    @IBOutlet weak var destinationName: UILabel!
    
    func configure(image: URL?, description: String?) {
        if let destinationDescription = description {
            self.destinationDescription.text = destinationDescription
        }
                
        if let imageURL = image {
            Nuke.loadImage(with: imageURL, into: destinationImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
