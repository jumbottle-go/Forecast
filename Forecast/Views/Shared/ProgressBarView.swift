import SwiftUI

struct ProgressBarView: View {
    let progress: CGFloat
    let fill: AnyShapeStyle

    init(progress: CGFloat, fill: some ShapeStyle) {
        self.progress = progress
        self.fill     = AnyShapeStyle(fill)
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.10))
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 4)
                    .fill(fill)
                    .frame(width: geo.size.width * progress, height: 8)
            }
        }
        .frame(height: 8)
    }
}
