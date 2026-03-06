import SwiftUI

struct ArticleView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss

    private var vm: ArticleViewModel { ArticleViewModel(article: article) }

    var body: some View {
        ZStack(alignment: .topLeading) {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Header image
                    AsyncImage(url: URL(string: vm.newsItem.imageURL)) { phase in
                        switch phase {
                        case .success(let img): img.resizable().scaledToFill()
                        default: Rectangle().fill(AppTheme.card)
                        }
                    }
                    .frame(height: 200)
                    .clipped()

                    // Category + title + meta — below image, no overlap possible
                    VStack(alignment: .leading, spacing: 8) {
                        // Category tag
                        HStack(spacing: 4) {
                            Image(systemName: vm.newsItem.category.symbol)
                                .font(.caption2.bold())
                            Text(vm.newsItem.category.rawValue)
                                .font(.caption.bold())
                        }
                        .foregroundStyle(AppTheme.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.accent.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                        Text(vm.newsItem.title)
                            .font(.title2.bold())
                            .foregroundStyle(AppTheme.textPrimary)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)

                        HStack(spacing: 6) {
                            Text(vm.newsItem.source)
                            Text("·")
                            Text(vm.newsItem.timeAgo)
                        }
                        .font(.caption)
                        .foregroundStyle(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    // MARK: Key Facts
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(vm.keyFacts) { fact in
                                HStack(spacing: 6) {
                                    Text(fact.emoji)
                                    Text(fact.text)
                                        .font(.caption)
                                        .foregroundStyle(AppTheme.textPrimary)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(AppTheme.card)
                                .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                                        .strokeBorder(AppTheme.border, lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                    }

                    // MARK: Body
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(vm.bodyParagraphs) { element in
                            switch element {
                            case .text(_, let content):
                                Text(content)
                                    .font(.subheadline)
                                    .foregroundStyle(AppTheme.textPrimary)
                                    .lineSpacing(5)

                            case .image(_, let url, let caption):
                                VStack(alignment: .leading, spacing: 6) {
                                    AsyncImage(url: URL(string: url)) { phase in
                                        switch phase {
                                        case .success(let img): img.resizable().scaledToFill()
                                        default: Rectangle().fill(AppTheme.border).frame(height: 160)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(AppTheme.border, lineWidth: 1)
                                    )

                                    Text(caption)
                                        .font(.caption)
                                        .foregroundStyle(AppTheme.textSecondary)
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    // MARK: Make Prediction block
                    predictionBlock

                    Color.clear.frame(height: 40)
                }
            }
            .scrollIndicators(.hidden)

            // Back button — pinned top-left, only as large as itself
            Button {
                dismiss()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.subheadline.bold())
                    Text("Назад")
                        .font(.subheadline.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(.black.opacity(0.50))
                .clipShape(Capsule())
            }
            .padding(.leading, 16)
            .padding(.top, 56)
        }
        .navigationBarHidden(true)
    }

    @ViewBuilder
    private var predictionBlock: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Background gradient
            VStack(alignment: .leading, spacing: 0) {
                // Header
                HStack(spacing: 10) {
                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundStyle(AppTheme.accent)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Сделайте предсказание")
                            .font(.headline)
                            .foregroundStyle(AppTheme.textPrimary)
                        Text("\(vm.questionCount) вопросов")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }

                // Preview questions
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(vm.previewQuestions.enumerated()), id: \.element.id) { i, q in
                        HStack(alignment: .top, spacing: 10) {
                            Text("\(i + 1)")
                                .font(.caption.bold())
                                .foregroundStyle(AppTheme.accent)
                                .frame(width: 18, height: 18)
                                .background(AppTheme.accent.opacity(0.15))
                                .clipShape(Circle())
                            Text(q.question)
                                .font(.subheadline)
                                .foregroundStyle(AppTheme.textPrimary)
                                .lineLimit(2)
                        }
                    }
                }
                .padding(.top, 18)

                // CTA
                NavigationLink {
                    DeckView(cards: vm.predictionQuestions)
                } label: {
                    Text("Начать предсказания")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(AppTheme.accent)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.buttonRadius))
                }
                .buttonStyle(.plain)
                .padding(.top, 20)
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: [AppTheme.accent.opacity(0.1), AppTheme.card],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                    .strokeBorder(AppTheme.border, lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
    }
}
