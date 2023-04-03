import UIKit

class StreamCell: UITableViewCell {

    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var continent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Configures the cell's UI for the given track.
    func configure(with destination: Destination) {
        cityAndCountry.text = destination.city! + ", " + destination.country!
        continent.text = destination.continent
    }

}
