import SwiftUI
import HealthKit

struct ContentView: View {
    
    public var healthStoreAuth = HKHealthStore()
    
    @State var totalHours: Int = 0
    @State var totalMins: Int = 0

    @ObservedObject var network = NetworkHelper()

    var body: some View {
        VStack {
            DaySleepList()
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Hello. You have slept:\n")  // self.network.totalSlept
                        .padding()
                        .onAppear(perform: {
                            start()
                        })
                        .font(.largeTitle)
                        .background(Color.black)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.purple)
                    Text(network.totalSlept)  // self.network.totalSlept
                        .padding()
                        .onAppear(perform: {
                            start()
                        })
                        .font(.largeTitle)
                        .background(Color.black)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
    
    func start() {
        print("Started")
        authorizeSleepAnalysis()
        print("Auth done")
        //print(self.network.totalSlept)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
