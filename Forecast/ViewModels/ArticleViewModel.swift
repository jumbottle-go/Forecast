import Foundation

final class ArticleViewModel: ObservableObject {
    let article: Article

    init(article: Article) {
        self.article = article
    }

    var newsItem: NewsItem { article.newsItem }
    var keyFacts: [KeyFact] { article.keyFacts }
    var bodyParagraphs: [BodyElement] { article.bodyParagraphs }
    var predictionQuestions: [PredictionCard] { article.predictionQuestions }

    var questionCount: Int { predictionQuestions.count }

    var previewQuestions: [PredictionCard] {
        Array(predictionQuestions.prefix(3))
    }
}
