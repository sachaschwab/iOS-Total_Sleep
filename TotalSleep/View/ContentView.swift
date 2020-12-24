import SwiftUI
import HealthKit

struct ContentView: View {
    
    public var healthStoreAuth = HKHealthStore()
    
    @State var totalHours: Int = 0
    @State var totalMins: Int = 0

    //@ObservedObject var network = NetworkHelper()
    //@ObservedObject var initialQuery = InitialDataLoad()
    
    init() {
            // NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            // NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UITableView.appearance().backgroundColor = UIColor.clear
        
        }

    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.black, .black]), center: .center, startRadius: 1, endRadius: 1000)
                    .edgesIgnoringSafeArea(.all)
                    DaySleepList()
            }.onAppear(perform: {
                start()
            })
            .navigationBarTitle("You slept").navigationBarHidden(false)
        }
    }
    
    func start() {
        print("Started")
        authorizeSleepAnalysis()
        print("Auth done")
        //print(self.network.totalSlept)
        //print("items count: \(self.initialQuery.items.count)")
        //if self.initialQuery.items.count == 0 {
            //self.initialQuery.items = [DaySleepItem(day: Date(), dayString: "Monday", totalSleep: "X dummy hours", totalSecondsSlept: 434)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
