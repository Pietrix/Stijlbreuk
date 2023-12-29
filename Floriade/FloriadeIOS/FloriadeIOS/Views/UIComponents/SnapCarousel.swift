import SwiftUI

struct CarouselConfig {
    var spacing: CGFloat
    var cardHeight: CGFloat
    var overlapSpacing: CGFloat

    var cardWidth: CGFloat { UIScreen.main.bounds.width - (overlapSpacing*2) - (spacing*2) }
    var leftPadding: CGFloat { overlapSpacing + spacing }
    var totalMovement: CGFloat { cardWidth + spacing }

    static let `default`: Self = CarouselConfig(spacing: 16, cardHeight: UIScreen.main.bounds.height > 600 ? 600 : UIScreen.main.bounds.height * 0.9 , overlapSpacing: 16)
}

public class CarouselModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct Carousel<ItemView : View> : View {
    let viewForItem: (Int) -> ItemView
    let itemCount: Int
    let config: CarouselConfig

    @GestureState var isDetectingLongPress = false
    @EnvironmentObject var carouselModel: CarouselModel

    @inlinable public init(items: Int,
                           _ config: CarouselConfig = .default,
                           @ViewBuilder _ viewForItem: @escaping (Int) -> ItemView) {
        self.viewForItem = viewForItem
        self.itemCount = items
        self.config = config
    }

    var body: some View {
        let totalSpacing = (CGFloat(itemCount) - 1) * config.spacing
        let totalCanvasWidth = (config.cardWidth * CGFloat(itemCount)) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2

        let activeOffset = xOffsetToShift + (config.leftPadding) - (config.totalMovement * CGFloat(carouselModel.activeCard))
        let nextOffset = xOffsetToShift + (config.leftPadding) - (config.totalMovement * CGFloat(carouselModel.activeCard) + 1)

        let calcOffset = activeOffset != nextOffset ? activeOffset + CGFloat(carouselModel.screenDrag) : CGFloat(activeOffset)


        return HStack(alignment: .center, spacing: config.spacing) {
            ForEach((0..<itemCount), id: \.self) { i in
                viewForItem(i)
            }
        }
        .offset(x: calcOffset, y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            carouselModel.screenDrag = Float(currentState.translation.width)
        }.onEnded { value in
            carouselModel.screenDrag = 0

            if value.translation.width < -50 && carouselModel.activeCard < itemCount - 1 {
                carouselModel.activeCard += 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

            if value.translation.width > 50 && carouselModel.activeCard > 0 {
                if carouselModel.activeCard - 1 < 0 { return }

                carouselModel.activeCard -= 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

extension View {
    func carouselItem( activeCard: Int) -> some View {
        let config: CarouselConfig = .default
        return self
            .frame(width: UIScreen.main.bounds.width - (config.overlapSpacing*2) - (config.spacing*2),
                   height: config.cardHeight)
            .cornerRadius(5)
            .animation(Animation.spring(), value: activeCard)
            .transition(.slide)
    }
}
