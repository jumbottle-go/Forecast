import Foundation

final class ArticleViewModel: ObservableObject {
    let article: Article

    init(article: Article) {
        self.article = article
    }

    var newsItem: NewsItem { article.newsItem }
    var keyFacts: [KeyFact] { article.keyFacts }
    var bodyParagraphs: [BodyElement] { article.bodyParagraphs }
}
