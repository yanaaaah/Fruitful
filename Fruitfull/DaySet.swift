import SwiftUICore


@Observable class DayDataStore {
    // This will hold the array
    var dayDataArray: [DaySet] = []
//    var goalData: DaySet = ...
}



struct DaySet {
    var sleep: Double
    var movement: Double
    var social: Double
    var personal: Double
    var downtime: Double
    var study: Double
    var work: Double
}


