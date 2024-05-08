import SwiftUI

///
/// A list of APIs with a button to invoke them.
/// After the data is retrieved, we display some sample data,
/// the "Date" response header value, and the "Cache-Control" response header
/// value.
///
struct RequestsView: View {
    @State private var viewmodel = RequestsViewModel()
    var body: some View {
        List {
            HStack {
                Toggle(isOn: $viewmodel.useV2API, label: {
                    Text("Use V2 API").font(.headline)
                })
            }
            .padding()

            apiListItem(withHeadline: "Product Data",
                        retreiveAction: viewmodel.retrieveProductById,
                        description: viewmodel.productDisplay?.displayString, date: viewmodel.productDisplay?.dateHeaderValue,
                        cacheControl: viewmodel.productDisplay?.cacheControlValue)
            apiListItem(withHeadline: "Orders Data",
                        retreiveAction: viewmodel.retrieveOrdersForCustomer,
                        description: viewmodel.orderDisplay?.displayString, date: viewmodel.orderDisplay?.dateHeaderValue,
                        cacheControl: viewmodel.orderDisplay?.cacheControlValue)
            apiListItem(withHeadline: "Customer Data",
                        retreiveAction: viewmodel.retrieveCustomer,
                        description: viewmodel.customerDisplay?.displayString, date: viewmodel.customerDisplay?.dateHeaderValue,
                        cacheControl: viewmodel.customerDisplay?.cacheControlValue)
            apiListItem(withHeadline: "Promotions Data",
                        retreiveAction: viewmodel.retrievePromotions,
                        description: viewmodel.promoDisplay?.displayString, date: viewmodel.promoDisplay?.dateHeaderValue,
                        cacheControl: viewmodel.promoDisplay?.cacheControlValue)

        }
        .padding()
    }
    
    /**
     Factory-type method for creating items to represent each
     API call in the List above.
     */
    private func apiListItem(withHeadline: String, retreiveAction: @escaping () -> Void, description: String?, date: String?, cacheControl: String?) -> some View {
        HStack {
            Text(withHeadline)
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing) {
                Text(description ?? "")
                Text(date ?? "")
                Text(cacheControl ?? "")
            }
            .font(.subheadline)
            // I know it's only a demo, but why can't we have nice things?
            .animation(.easeInOut(duration: 0.5), value: date)
            Image(systemName: "arrow.clockwise.circle")
                .font(.title)
                .onTapGesture(perform: {
                    retreiveAction()
                })
        }
        .padding()
    }
}


