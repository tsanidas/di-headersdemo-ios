import SwiftUI
import Combine

///
/// This is where the ugly stuff lives, like data retrieval, etc
/// This API is publicly available via Google App Engine
/// To see the Swagger UI docs, go to ${urlBase}/swagger-ui/index.html
///
@Observable
class RequestsViewModel {
    static let urlBase = "https://headers-demo.ue.r.appspot.com" 
    // "http://localhost:8080" 
        // 
    private var cancellables = Set<AnyCancellable>()
    var productDisplay: ApiDisplayBlock?
    var orderDisplay: ApiDisplayBlock?
    var customerDisplay: ApiDisplayBlock?
    var promoDisplay: ApiDisplayBlock?
        
    ///
    /// Method to retrieve products using fixed (fake) product ID numbers
    ///
    func retrieveProductById() {
        guard let url = URL(string: "\(RequestsViewModel.urlBase)/products/2") else {
            print("Invalid URL")
            return
        }
        var pd = ApiDisplayBlock(displayString: "", dateHeaderValue: "", cacheControlValue: "")

        cancellables.insert(
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse, userInfo: ["data": data, "response": response])
                    }
                    if let cacheControl = httpResponse.value(forHTTPHeaderField: "Cache-Control") {
                        pd.cacheControlValue = cacheControl
                    } else {
                        pd.cacheControlValue = "-"
                    }
                    if let prd = httpResponse.value(forHTTPHeaderField: "Date") {
                        pd.dateHeaderValue = prd
                    }
                    return data
                })
                .decode(type: Product.self, decoder: CodableHelper.jsonDecoder)
                .eraseToAnyPublisher()
                .sink { completion in
                    print("Product retrieval complete \(completion)")
                } receiveValue: { product in
                    pd.displayString = product.description ?? ""
                    self.productDisplay = pd
                }
        )
    }
    
    ///
    /// Retrieve orders data for a fixed (fake) customerId
    ///
    func retrieveOrdersForCustomer() {
        guard let url = URL(string: "\(RequestsViewModel.urlBase)/orders/customer/994") else {
            print("Invalid URL")
            return
        }
        
        var od = ApiDisplayBlock(displayString: "", dateHeaderValue: "", cacheControlValue: "")

        cancellables.insert(
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse, userInfo: ["data": data, "response": response])
                    }
                    if let cacheControl = httpResponse.value(forHTTPHeaderField: "Cache-Control") {
                        od.cacheControlValue = cacheControl
                    } else {
                        od.cacheControlValue = "-"
                    }
                    if let ordDate = httpResponse.value(forHTTPHeaderField: "Date") {
                        od.dateHeaderValue = ordDate
                    }
                    return data
                })
                .decode(type: [Order].self, decoder: CodableHelper.jsonDecoder)
                .eraseToAnyPublisher()
                .sink { completion in
                    print("Orders retrieval complete \(completion)")
                } receiveValue: { orders in
                    var orderStr = ""
                    if let oid = orders.first?.id, oid > 0 {
                        orderStr = String(oid)
                    }
                    od.displayString = orderStr
                    self.orderDisplay = od
                }
        )
    }
    
    ///
    /// Retrieve customer data for a fixed (fake) customerId
    ///
    func retrieveCustomer() {
        guard let url = URL(string: "\(RequestsViewModel.urlBase)/customers/994") else {
            print("Invalid URL")
            return
        }
        
        var cd = ApiDisplayBlock(displayString: "", dateHeaderValue: "", cacheControlValue: "")
        
        cancellables.insert(
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse, userInfo: ["data": data, "response": response])
                    }
                    if let cacheControl = httpResponse.value(forHTTPHeaderField: "Cache-Control") {
                        cd.cacheControlValue = cacheControl
                    } else {
                        cd.cacheControlValue = "-"
                    }
                    if let cDataDate = httpResponse.value(forHTTPHeaderField: "Date") {
                        cd.dateHeaderValue = cDataDate
                    }
                    return data
                })
                .decode(type: Customer.self, decoder: CodableHelper.jsonDecoder)
                .eraseToAnyPublisher()
                .sink { completion in
                    print("Customer retrieval complete \(completion)")
                } receiveValue: { cust in
                    cd.displayString = cust.name ?? ""
                    self.customerDisplay = cd
                }
        )
    }
    
    ///
    /// Retrieve promotions data associated with a fixed (fake) productId
    ///
    func retrievePromotions() {
        guard let url = URL(string: "\(RequestsViewModel.urlBase)/promotions/product/1") else {
            print("Invalid URL")
            return
        }
        
        var pd = ApiDisplayBlock(displayString: "", dateHeaderValue: "", cacheControlValue: "")
        
        cancellables.insert(
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse, userInfo: ["data": data, "response": response])
                    }
                    if let cacheControl = httpResponse.value(forHTTPHeaderField: "Cache-Control") {
                        pd.cacheControlValue = cacheControl
                    } else {
                        pd.cacheControlValue = "-"
                    }
                    if let cDataDate = httpResponse.value(forHTTPHeaderField: "Date") {
                        pd.dateHeaderValue = cDataDate
                    }
                    return data
                })
                .decode(type: [Promotion].self, decoder: CodableHelper.jsonDecoder)
                .eraseToAnyPublisher()
                .sink { completion in
                    print("Promotions retrieval complete \(completion)")
                } receiveValue: { promos in
                    pd.displayString = promos.first?.title ?? ""
                    self.promoDisplay = pd
                }
        )
    }
}

///
/// "Resolved" view data, i.e. no optionals and displayable default values
///
struct ApiDisplayBlock {
    var displayString: String
    var dateHeaderValue: String
    var cacheControlValue: String
}
