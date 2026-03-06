import Foundation

// MARK: - Mock News Items

enum MockData {

    // MARK: Breaking Hero
    static let breakingHero = NewsItem(
        title: "US-China Trade War Escalates: New 145% Tariffs on Tech Imports",
        subtitle: "Washington imposes sweeping new duties on semiconductors and consumer electronics as Beijing vows immediate retaliation.",
        imageURL: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
        source: "Reuters",
        timeAgo: "14 мин.",
        votesCount: 8_412,
        category: .politics,
        isBreaking: true,
        question: "Will China retaliate with counter-tariffs within 48 hours?",
        options: [
            VoteOption(emoji: "🔥", text: "Да, немедленно", subtitle: "Пекин уже предупредил о мерах", percent: 62),
            VoteOption(emoji: "🕊️", text: "Нет, переговоры", subtitle: "Дипломатическое решение", percent: 24),
            VoteOption(emoji: "⏳", text: "Позже", subtitle: "Через 1–2 недели", percent: 14)
        ]
    )

    // MARK: Finance
    static let financeNews: [NewsItem] = [
        NewsItem(
            title: "Fed Holds Rates at 4.75% Amid Inflation Uncertainty",
            subtitle: "Powell signals 'wait-and-see' stance as jobs data remains strong and core inflation ticks upward.",
            imageURL: "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=800&q=80",
            source: "Bloomberg",
            timeAgo: "1 ч.",
            votesCount: 4_231,
            category: .finance,
            question: "Will the Fed cut rates before Q3 2026?",
            options: [
                VoteOption(emoji: "✂️", text: "Да, снизит", subtitle: "Экономика замедлится", percent: 44),
                VoteOption(emoji: "🔒", text: "Нет, заморозка", subtitle: "Инфляция держится", percent: 56)
            ]
        ),
        NewsItem(
            title: "Bitcoin Surges Past $128,000 — New All-Time High",
            subtitle: "Institutional demand and ETF inflows push BTC to historic levels, with analysts eyeing $150K next.",
            imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
            source: "CoinDesk",
            timeAgo: "2 ч.",
            votesCount: 12_870,
            category: .finance,
            question: "Will Bitcoin reach $150,000 within 60 days?",
            options: [
                VoteOption(emoji: "🚀", text: "Да, побьёт", subtitle: "Бычий тренд продолжается", percent: 58),
                VoteOption(emoji: "📉", text: "Нет, коррекция", subtitle: "Рынок перегрет", percent: 42)
            ]
        ),
        NewsItem(
            title: "Nvidia Reports $42B Quarter, Raises Guidance Again",
            subtitle: "Data center revenue soars 122% YoY as demand for AI chips continues to outpace supply globally.",
            imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
            source: "CNBC",
            timeAgo: "3 ч.",
            votesCount: 6_540,
            category: .finance,
            question: "Will NVDA stock hit $200 by end of 2026?",
            options: [
                VoteOption(emoji: "📈", text: "Да, вырастет", subtitle: "ИИ-бум продолжается", percent: 71),
                VoteOption(emoji: "📊", text: "Нет, плато", subtitle: "Конкуренты давят", percent: 29)
            ]
        )
    ]

    // MARK: Tech
    static let techNews: [NewsItem] = [
        NewsItem(
            title: "OpenAI Launches GPT-5: Scores 97% on Bar Exam, 'Thinks' in Real-Time",
            subtitle: "The new model demonstrates unprecedented reasoning and multi-step problem solving, raising new alignment concerns.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "The Verge",
            timeAgo: "30 мин.",
            votesCount: 21_050,
            category: .tech,
            question: "Will GPT-5 trigger major AI regulation in the EU within 6 months?",
            options: [
                VoteOption(emoji: "⚖️", text: "Да, запретят", subtitle: "Брюссель уже изучает", percent: 53),
                VoteOption(emoji: "🤖", text: "Нет, интегрируют", subtitle: "Регуляторы отстают", percent: 47)
            ]
        ),
        NewsItem(
            title: "Apple Vision Pro 2 Leaks: 4K Micro-OLED, Half the Weight",
            subtitle: "Internal documents suggest a spring release at $2,499 with a new 'spatial OS' optimized for professional workflows.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "9to5Mac",
            timeAgo: "4 ч.",
            votesCount: 9_103,
            category: .tech,
            question: "Will Vision Pro 2 sell 1 million units in its first year?",
            options: [
                VoteOption(emoji: "🥽", text: "Да, бестселлер", subtitle: "Цена стала доступнее", percent: 39),
                VoteOption(emoji: "💸", text: "Нет, нишевый", subtitle: "Всё равно дорого", percent: 61)
            ]
        ),
        NewsItem(
            title: "Google Achieves Quantum Error Correction Milestone with Willow 2",
            subtitle: "The 1,000-qubit processor solves in minutes what classical supercomputers would need 10²⁵ years for.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "Nature",
            timeAgo: "6 ч.",
            votesCount: 3_782,
            category: .tech,
            question: "Will quantum computing make current encryption obsolete by 2030?",
            options: [
                VoteOption(emoji: "🔐", text: "Да, взломают", subtitle: "Темп развития ускоряется", percent: 35),
                VoteOption(emoji: "🛡️", text: "Нет, защитятся", subtitle: "Post-quantum крипто готова", percent: 65)
            ]
        )
    ]

    // MARK: Politics
    static let politicsNews: [NewsItem] = [
        NewsItem(
            title: "EU Emergency Summit: Member States Agree on €800B Defense Fund",
            subtitle: "European leaders reach historic consensus after months of deadlock, signalling a major shift in continental security policy.",
            imageURL: "https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=800&q=80",
            source: "Politico EU",
            timeAgo: "5 ч.",
            votesCount: 5_329,
            category: .politics,
            question: "Will the EU defense fund be ratified by all 27 members?",
            options: [
                VoteOption(emoji: "🇪🇺", text: "Да, единогласно", subtitle: "Давление Трампа объединяет", percent: 67),
                VoteOption(emoji: "❌", text: "Нет, блокируют", subtitle: "Венгрия против", percent: 33)
            ]
        ),
        NewsItem(
            title: "NATO Votes on Georgia & Moldova Accession — Decision Next Week",
            subtitle: "Alliance foreign ministers convene in Brussels as Russia warns of 'red lines' if former Soviet states join.",
            imageURL: "https://images.unsplash.com/photo-1565339852682-03d741248e71?w=800&q=80",
            source: "AP News",
            timeAgo: "8 ч.",
            votesCount: 4_014,
            category: .politics,
            question: "Will NATO accept Georgia and Moldova as members in 2026?",
            options: [
                VoteOption(emoji: "✅", text: "Да, примут", subtitle: "Геополитика требует", percent: 41),
                VoteOption(emoji: "🚫", text: "Нет, отложат", subtitle: "Консенсус не достигнут", percent: 59)
            ]
        ),
        NewsItem(
            title: "UN Security Council Votes on Global AI Governance Treaty",
            subtitle: "China and Russia's expected veto threatens to derail the first international framework for frontier AI systems.",
            imageURL: "https://images.unsplash.com/photo-1562907550-096453ea34f6?w=800&q=80",
            source: "Guardian",
            timeAgo: "10 ч.",
            votesCount: 2_883,
            category: .politics,
            question: "Will the UN AI treaty pass the Security Council vote?",
            options: [
                VoteOption(emoji: "📋", text: "Да, примут", subtitle: "США и ЕС лоббируют", percent: 28),
                VoteOption(emoji: "🗳️", text: "Нет, вето", subtitle: "Китай и РФ заблокируют", percent: 72)
            ]
        )
    ]

    // MARK: Sports
    static let sportsNews: [NewsItem] = [
        NewsItem(
            title: "Champions League Semi-Finals: Real Madrid vs Arsenal — Who Advances?",
            subtitle: "A classic European clash set for Tuesday; Madrid missing Vinicius, Arsenal unbeaten in the competition this season.",
            imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
            source: "Sky Sports",
            timeAgo: "2 ч.",
            votesCount: 18_440,
            category: .sports,
            question: "Will Real Madrid reach the Champions League final?",
            options: [
                VoteOption(emoji: "⚽", text: "Да, «Реал»", subtitle: "Опыт и класс", percent: 55),
                VoteOption(emoji: "🔴", text: "Нет, «Арсенал»", subtitle: "Молодая злость", percent: 45)
            ]
        ),
        NewsItem(
            title: "F1 2026: New Engine Regs Shake Up the Grid — Ferrari Favourite?",
            subtitle: "Teams complete mandatory homologation tests as analysts suggest the new hybrid power units favour Ferrari's design philosophy.",
            imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
            source: "F1.com",
            timeAgo: "5 ч.",
            votesCount: 7_660,
            category: .sports,
            question: "Will Ferrari win the 2026 F1 Constructors' Championship?",
            options: [
                VoteOption(emoji: "🏎️", text: "Да, «Феррари»", subtitle: "Двигатель под их стиль", percent: 38),
                VoteOption(emoji: "🏆", text: "Нет, другая", subtitle: "Mercedes или Red Bull", percent: 62)
            ]
        ),
        NewsItem(
            title: "NBA Trade Deadline Bombshell: LeBron to Warriors in 3-Team Deal",
            subtitle: "The blockbuster trade reunites LeBron James with a championship-calibre roster in what insiders call 'the deal of the decade'.",
            imageURL: "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800&q=80",
            source: "ESPN",
            timeAgo: "1 ч.",
            votesCount: 31_205,
            category: .sports,
            question: "Will the Warriors win the 2026 NBA Championship with LeBron?",
            options: [
                VoteOption(emoji: "🏀", text: "Да, чемпионы", subtitle: "ЛеБрон меняет всё", percent: 61),
                VoteOption(emoji: "❄️", text: "Нет, не выйдет", subtitle: "Нужна командная химия", percent: 39)
            ]
        )
    ]

    // MARK: Science
    static let scienceNews: [NewsItem] = [
        NewsItem(
            title: "NASA Confirms Liquid Water Reservoir Beneath Mars South Pole",
            subtitle: "New radar data from MAVEN-2 reveals a 30km wide brine lake 1.5km below the surface — the largest confirmed body of Martian water.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "NASA JPL",
            timeAgo: "3 ч.",
            votesCount: 14_722,
            category: .science,
            question: "Will evidence of microbial life be found in the Martian water?",
            options: [
                VoteOption(emoji: "🦠", text: "Да, жизнь есть", subtitle: "Условия подходящие", percent: 34),
                VoteOption(emoji: "🌑", text: "Нет, стерильно", subtitle: "Радиация и соль", percent: 66)
            ]
        ),
        NewsItem(
            title: "mRNA Cancer Vaccine Shows 93% Efficacy in Phase 3 Trials",
            subtitle: "BioNTech and Moderna's personalised tumour vaccine prevents recurrence in pancreatic and lung cancer patients for 3+ years.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "NEJM",
            timeAgo: "7 ч.",
            votesCount: 9_881,
            category: .science,
            question: "Will this mRNA vaccine receive FDA approval in 2026?",
            options: [
                VoteOption(emoji: "💉", text: "Да, одобрят", subtitle: "Данные убедительные", percent: 78),
                VoteOption(emoji: "⏸️", text: "Нет, задержка", subtitle: "Нужны доп. данные", percent: 22)
            ]
        ),
        NewsItem(
            title: "Scientists Confirm Atlantic Circulation (AMOC) Approaching Collapse Threshold",
            subtitle: "New temperature gradient data from 1,200 buoys shows AMOC strength at its lowest point in 1,600 years, accelerating this decade.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "Nature Climate Change",
            timeAgo: "9 ч.",
            votesCount: 6_103,
            category: .science,
            question: "Will AMOC fully collapse before 2100?",
            options: [
                VoteOption(emoji: "🌊", text: "Да, коллапс", subtitle: "Тренды неумолимы", percent: 47),
                VoteOption(emoji: "♻️", text: "Нет, стабилизируют", subtitle: "Снижение CO2 поможет", percent: 53)
            ]
        )
    ]

    // MARK: All news (excluding hero)
    static var allNews: [NewsItem] {
        financeNews + techNews + politicsNews + sportsNews + scienceNews
    }

    // MARK: Articles
    static var articles: [UUID: Article] = {
        var dict: [UUID: Article] = [:]

        // Breaking article
        let breakingArticle = Article(
            newsItem: breakingHero,
            keyFacts: [
                KeyFact(emoji: "📦", text: "145% tariff on chips"),
                KeyFact(emoji: "💵", text: "$380B trade volume at risk"),
                KeyFact(emoji: "⚠️", text: "TSMC supply chains affected"),
                KeyFact(emoji: "🇨🇳", text: "Beijing: 'firm countermeasures'"),
                KeyFact(emoji: "📉", text: "Nasdaq -3.2% on open")
            ],
            bodyParagraphs: [
                .text(UUID(), "The White House announced Monday a sweeping tariff package targeting Chinese technology imports, covering semiconductors, smartphones, laptops, and advanced manufacturing equipment. The 145% rate — nearly double the previous ceiling — takes effect Friday, giving importers less than 96 hours to adjust supply chains."),
                .image(UUID(), "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80", "U.S. goods trade deficit with China, 2019–2025"),
                .text(UUID(), "China's Ministry of Commerce described the move as 'economic bullying' and called an emergency session of the State Council. Officials hinted at restricting rare earth exports and suspending Boeing aircraft deliveries — moves that would send shockwaves through aerospace and EV supply chains globally."),
                .text(UUID(), "Markets reacted immediately. The Philadelphia Semiconductor Index fell 4.8% while the yuan weakened to 7.42 per dollar. Analysts at Goldman Sachs raised their recession probability estimate for the U.S. to 35% for 2026, citing cascading supply-chain disruptions as the primary risk channel."),
                .image(UUID(), "https://images.unsplash.com/photo-1565339852682-03d741248e71?w=800&q=80", "Cargo containers at the Port of Los Angeles — the busiest U.S. entry point for Chinese goods")
            ],
            predictionQuestions: [
                PredictionCard(
                    question: "Will China formally announce counter-tariffs within 48 hours?",
                    imageURL: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
                    daysLeft: 2, yesPercent: 62, noPercent: 38, totalVotes: 8412,
                    aiAnalysis: "Historical precedent from the 2018–2019 trade war strongly suggests China will respond within 48 hours. Beijing has a documented pattern of proportional retaliation — often matching the economic scope of U.S. measures within one to three business days.\n\nKey factors favouring a rapid response: China's State Council convened an emergency session within hours of the announcement; rare earth export restrictions are pre-drafted and require only presidential sign-off; and the Communist Party's domestic audience expects a visible and immediate show of strength.\n\nProbability estimate: 68–72% chance of formal counter-tariff announcement within 48 hours. The primary downside scenario involves back-channel diplomatic negotiations — which sources indicate are ongoing despite the public rhetoric."
                ),
                PredictionCard(
                    question: "Will the Nasdaq drop more than 5% in the next week?",
                    imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
                    daysLeft: 7, yesPercent: 54, noPercent: 46, totalVotes: 6230,
                    aiAnalysis: "Technology stocks are uniquely exposed to US-China trade disruption. Over 40% of S&P 500 tech companies derive more than 20% of revenue from Chinese markets or Chinese-assembled supply chains.\n\nHistorically, the Nasdaq fell 7.4% in the week following Trump's May 2019 tariff escalation. Current valuations are stretched — the index trades at 28x forward earnings vs. the 10-year average of 21x — leaving less buffer for negative macro shocks.\n\nEstimated probability of a >5% weekly drop: 55%. A key mitigant is the prospect of emergency Fed commentary reassuring markets, which Powell deployed effectively in December 2018."
                ),
                PredictionCard(
                    question: "Will TSMC announce supply chain diversification by end of Q2?",
                    imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
                    daysLeft: 45, yesPercent: 71, noPercent: 29, totalVotes: 4100,
                    aiAnalysis: "TSMC's board has been under sustained pressure from both Washington and Taipei to accelerate geographic diversification since 2023. Their Arizona fab (Fab 21) is already operational for N4 node, and the Japanese Kumamoto fab began risk production in Q1 2026.\n\nThis latest tariff escalation provides a compelling business case — and public cover — for TSMC to accelerate announcements about new capacity in the US, Japan, or Germany. CEO C.C. Wei is scheduled to speak at the Computex keynote in May, which analysts believe is the most likely venue for a major announcement.\n\nProbability: ~73% that TSMC makes a meaningful supply-chain diversification statement before June 30."
                )
            ]
        )
        dict[breakingHero.id] = breakingArticle

        // Finance 1 — Fed rates
        let fed = financeNews[0]
        dict[fed.id] = Article(
            newsItem: fed,
            keyFacts: [
                KeyFact(emoji: "📊", text: "Rate: 4.75% unchanged"),
                KeyFact(emoji: "📈", text: "Core CPI: 3.1% YoY"),
                KeyFact(emoji: "💼", text: "Unemployment: 3.8%"),
                KeyFact(emoji: "🏦", text: "2 cuts priced in 2026")
            ],
            bodyParagraphs: [
                .text(UUID(), "The Federal Open Market Committee voted unanimously to hold the benchmark federal funds rate at 4.75–5.00%, matching market expectations. Chair Jerome Powell struck a cautious tone at the press conference, emphasising that the committee needs 'greater confidence' that inflation is sustainably moving toward its 2% target before reducing rates."),
                .image(UUID(), "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=800&q=80", "Federal Reserve headquarters, Washington D.C."),
                .text(UUID(), "The decision comes against a backdrop of resilient consumer spending and a labour market that has defied predictions of cooling. Nonfarm payrolls added 203,000 jobs in February — above the 180,000 consensus — while the unemployment rate held at 3.8%. Core PCE, the Fed's preferred inflation gauge, printed at 2.8% for January, still above target."),
                .text(UUID(), "Fed Funds futures markets now price in a 55% probability of a first cut in July, down from 72% before the meeting. Two rate cuts by year-end remain the base case for Goldman Sachs and JPMorgan, though both institutions flagged tariff-driven inflation as the primary upside risk to the price level.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will the Fed cut rates at the July meeting?",
                               imageURL: "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=800&q=80",
                               daysLeft: 120, yesPercent: 55, noPercent: 45, totalVotes: 4231,
                               aiAnalysis: "The Fed has signalled a data-dependent approach, which means June CPI and jobs reports will be decisive. If core inflation falls below 2.5% by June, a July cut is very likely (>70%). Current trajectory suggests that is achievable absent a tariff-driven price shock.\n\nHistorically, the Fed has tended to cut within two meetings of the last hike when core PCE drops below 3%. We crossed that threshold in December 2025. Probability: 52–58% for a July cut."),
                PredictionCard(question: "Will there be more than 2 rate cuts in 2026?",
                               imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
                               daysLeft: 270, yesPercent: 33, noPercent: 67, totalVotes: 3100,
                               aiAnalysis: "The new tariff regime substantially complicates the Fed's calculus. Tariffs are inflationary in the short run, which may force the Fed to hold rates higher for longer even as growth slows — a classic stagflation dilemma.\n\nOf the last four tightening cycles, only one saw more than two cuts in the following year when inflation was still above 2.5%. Probability of more than two cuts in 2026: approximately 28–35%."),
                PredictionCard(question: "Will the 10-year Treasury yield exceed 5% by summer?",
                               imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
                               daysLeft: 90, yesPercent: 42, noPercent: 58, totalVotes: 2800,
                               aiAnalysis: "The 10-year yield has been range-bound at 4.4–4.7% since January. Breaking above 5% would require either a significant inflation re-acceleration or a debt issuance shock. The Treasury's Q2 refunding is elevated at $1.1 trillion, but foreign demand — particularly from Japan and the UK — has remained surprisingly resilient.\n\nProbability of 5%+ yield by July: 38–42%.")
            ]
        )

        // Finance 2 — Bitcoin
        let btc = financeNews[1]
        dict[btc.id] = Article(
            newsItem: btc,
            keyFacts: [
                KeyFact(emoji: "₿", text: "Price: $128,400"),
                KeyFact(emoji: "📥", text: "$3.2B ETF inflows this week"),
                KeyFact(emoji: "🏦", text: "BlackRock holds 312K BTC"),
                KeyFact(emoji: "🔄", text: "Halving: 14 months ago")
            ],
            bodyParagraphs: [
                .text(UUID(), "Bitcoin surged past $128,000 for the first time on Tuesday, driven by record weekly inflows into spot Bitcoin ETFs and growing institutional allocation from sovereign wealth funds. The move extends a rally that began in mid-January following the approval of a BTC strategic reserve by the U.S. government."),
                .image(UUID(), "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80", "Bitcoin price chart — the new all-time high breached $128K"),
                .text(UUID(), "BlackRock's iShares Bitcoin Trust (IBIT) alone absorbed $1.4 billion in a single session, the largest single-day inflow since its launch. On-chain data shows long-term holder supply at a 3-year high, suggesting most selling pressure is exhausted. The fear and greed index sits at 89 — 'extreme greed' — a level historically followed by short-term consolidation.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will Bitcoin reach $150,000 within 60 days?",
                               imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
                               daysLeft: 60, yesPercent: 58, noPercent: 42, totalVotes: 12870,
                               aiAnalysis: "Post-halving cycles historically deliver peak prices 12–18 months after the halving event (April 2024). The current timeline is consistent with the 2020-cycle peak in November 2021. Stock-to-flow model projects $180K–$220K as a cycle top.\n\nHowever, at extreme greed readings (89/100), markets often consolidate for 3–6 weeks before resuming uptrends. Probability of reaching $150K within 60 days: 55–62%."),
                PredictionCard(question: "Will altcoins outperform BTC in the next 30 days?",
                               imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
                               daysLeft: 30, yesPercent: 64, noPercent: 36, totalVotes: 8900,
                               aiAnalysis: "Bitcoin dominance typically peaks and then falls as retail capital rotates into altcoins (the 'altseason' phenomenon). Current BTC dominance is 57%, near historical inflection points observed before major altcoin rotations in 2017 and 2021.\n\nEthereum, Solana, and AI-related tokens are positioned for outperformance if BTC consolidates. Probability of altcoin outperformance in the next 30 days: 62–67%."),
                PredictionCard(question: "Will BTC drop below $100,000 before year end?",
                               imageURL: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
                               daysLeft: 300, yesPercent: 29, noPercent: 71, totalVotes: 7200,
                               aiAnalysis: "A drop below $100K would represent a 22%+ drawdown from current levels. While Bitcoin has historically experienced 30–40% corrections mid-cycle, the structural demand from ETFs and sovereign reserves creates strong technical support between $95K and $105K.\n\nProbability of a sub-$100K close before December 31, 2026: approximately 25–30%.")
            ]
        )

        // Finance 3 — Nvidia
        let nvda = financeNews[2]
        dict[nvda.id] = Article(
            newsItem: nvda,
            keyFacts: [
                KeyFact(emoji: "💰", text: "Revenue: $42.1B (+122% YoY)"),
                KeyFact(emoji: "🖥️", text: "Data center: $35.8B"),
                KeyFact(emoji: "📊", text: "EPS: $0.89 vs $0.84 est."),
                KeyFact(emoji: "🚀", text: "Q2 guide: $45B+")
            ],
            bodyParagraphs: [
                .text(UUID(), "Nvidia reported fiscal Q4 2026 revenue of $42.1 billion, smashing analyst estimates of $38.2 billion and delivering its eighth consecutive quarter of triple-digit year-over-year data center growth. CEO Jensen Huang described demand as 'insatiable', pointing to the global build-out of AI inference infrastructure as an accelerating rather than decelerating force."),
                .image(UUID(), "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80", "Nvidia H200 GPU cluster — now shipping to hyperscalers globally"),
                .text(UUID(), "The Blackwell architecture, which powers the company's flagship H200 and B100 chips, saw production yields improve significantly in Q4, allowing Nvidia to ramp shipments faster than anticipated. The company also unveiled the GB300 'Blackwell Ultra' roadmap for Q3 2026, promising 2x performance per watt — a development that left AMD and Intel's AI roadmaps looking increasingly distant.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will NVDA stock reach $200 per share by December 2026?",
                               imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
                               daysLeft: 300, yesPercent: 71, noPercent: 29, totalVotes: 6540,
                               aiAnalysis: "At current prices (~$155), reaching $200 implies approximately 29% upside. Nvidia's forward P/E of 32x is actually below its 3-year average of 40x, suggesting the stock is not richly valued relative to its growth rate.\n\nCatalysts: GB300 launch in Q3, potential new China-export-exempt SKUs, and continued hyperscaler capex increases. Risk factors: tariff impact on hardware costs and a potential AI investment cycle pause. Probability: 68–74%."),
                PredictionCard(question: "Will AMD close the AI chip gap with Nvidia by end of 2026?",
                               imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
                               daysLeft: 270, yesPercent: 24, noPercent: 76, totalVotes: 4200,
                               aiAnalysis: "AMD's MI350 series is gaining traction in specific inference workloads and has won meaningful contracts from Microsoft Azure and Meta. However, Nvidia's CUDA ecosystem represents a 10+ year software moat that AMD cannot close in under 24 months.\n\nMarket share gap in AI accelerators: Nvidia ~88%, AMD ~7%. For AMD to meaningfully close this gap, it would need to capture 15%+ share — unprecedented in 18 months. Probability: 18–24%."),
                PredictionCard(question: "Will Nvidia face significant revenue decline due to China tariffs?",
                               imageURL: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
                               daysLeft: 180, yesPercent: 37, noPercent: 63, totalVotes: 3800,
                               aiAnalysis: "China accounted for ~15% of Nvidia's revenue before export controls kicked in (2023). The company has largely redirected capacity to US, European, and Southeast Asian customers. A >5% revenue decline specifically attributable to China tariffs is unlikely given existing diversification.\n\nHowever, if tariffs trigger retaliatory bans on US chip software or CUDA licensing in China, the indirect effects could be more severe. Probability of meaningful revenue decline: 32–38%.")
            ]
        )

        // Tech 1 — GPT-5
        let gpt = techNews[0]
        dict[gpt.id] = Article(
            newsItem: gpt,
            keyFacts: [
                KeyFact(emoji: "🧠", text: "97% Bar Exam score"),
                KeyFact(emoji: "⚡", text: "10x faster than GPT-4"),
                KeyFact(emoji: "🌍", text: "Supports 50 languages"),
                KeyFact(emoji: "🔬", text: "Passes PhD-level science evals")
            ],
            bodyParagraphs: [
                .text(UUID(), "OpenAI released GPT-5 to ChatGPT Plus and API customers simultaneously, describing it as 'the first model to demonstrate genuine multi-step reasoning in real time'. In benchmark testing, GPT-5 scored 97th percentile on the LSAT, 94th on the USMLE medical board exam, and achieved a perfect score on the International Mathematical Olympiad qualifier for the first time by any AI system."),
                .image(UUID(), "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80", "GPT-5 benchmark comparison — significantly ahead across reasoning tasks"),
                .text(UUID(), "The model introduces 'chain-of-thought streaming' — users can watch the model reason step-by-step in real time before delivering answers. Safety evaluations revealed GPT-5 scored in the 'high risk' tier on three out of fifteen categories in METR's autonomy evaluations, prompting OpenAI to apply additional output restrictions not present in the research preview.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will GPT-5 trigger major EU AI Act enforcement within 6 months?",
                               imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
                               daysLeft: 180, yesPercent: 53, noPercent: 47, totalVotes: 21050,
                               aiAnalysis: "Under the EU AI Act, frontier AI models above certain compute thresholds face mandatory safety reporting, red-teaming obligations, and potential capability restrictions. GPT-5 almost certainly crosses these thresholds.\n\nThe European AI Office is already investigating GPT-4's compliance. GPT-5's deployment would accelerate that timeline. However, 'enforcement' involving fines or access restrictions within 6 months would be unusually fast for EU regulatory processes. Probability: 48–55%."),
                PredictionCard(question: "Will OpenAI release GPT-6 within 12 months?",
                               imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
                               daysLeft: 365, yesPercent: 41, noPercent: 59, totalVotes: 15200,
                               aiAnalysis: "OpenAI's release cadence has compressed significantly: GPT-3 to GPT-4 took 3 years; GPT-4 to GPT-5 took approximately 2 years. However, the computational and safety requirements for each successive generation are scaling non-linearly.\n\nSam Altman has hinted at a 'continuous improvement' model replacing discrete version releases. A full GPT-6 within 12 months appears unlikely at ~35–40%, though incremental GPT-5.5 style releases are probable."),
                PredictionCard(question: "Will a competitor (Google/Meta/Anthropic) match GPT-5 within 3 months?",
                               imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
                               daysLeft: 90, yesPercent: 67, noPercent: 33, totalVotes: 18300,
                               aiAnalysis: "Google's Gemini Ultra 2.0 and Anthropic's Claude 4 Opus are already in advanced evaluation stages. Leaked internal benchmarks suggest both achieve within 5–8% of GPT-5 on reasoning tasks.\n\nGiven the pace of frontier AI development and the competitive pressure, it is likely that at least one competitor will release a model that credibly matches or exceeds GPT-5's public benchmarks within 3 months. Probability: 65–70%.")
            ]
        )

        // Sports 1 — Champions League
        let cl = sportsNews[0]
        dict[cl.id] = Article(
            newsItem: cl,
            keyFacts: [
                KeyFact(emoji: "🏟️", text: "Venue: Santiago Bernabéu"),
                KeyFact(emoji: "⚽", text: "Arsenal: unbeaten in UCL"),
                KeyFact(emoji: "🤕", text: "Vinicius: doubtful (hamstring)"),
                KeyFact(emoji: "📺", text: "Kick-off: 21:00 CET Tuesday")
            ],
            bodyParagraphs: [
                .text(UUID(), "Real Madrid host Arsenal in the first leg of a hotly anticipated Champions League semi-final that has captivated European football fans. Arsenal, managed by Mikel Arteta, arrive in Madrid unbeaten in the competition — winning all eight group and knockout stage matches — while Real Madrid are seeking their fourth Champions League title in eight seasons."),
                .image(UUID(), "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80", "The Bernabéu under floodlights — site of countless European nights"),
                .text(UUID(), "The tie is delicately poised given Vinicius Jr's injury doubt. The Brazilian winger has been directly involved in 19 Champions League goals over the past two seasons. Without him, Madrid's attacking threat diminishes significantly, potentially favouring Arsenal's high-intensity pressing game which has dismantled every opponent it has faced this campaign.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will Real Madrid win the first leg at the Bernabéu?",
                               imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
                               daysLeft: 3, yesPercent: 55, noPercent: 45, totalVotes: 18440,
                               aiAnalysis: "Real Madrid's home record in European knockout ties is exceptional: 18 wins from their last 22 home legs. However, Arsenal's defensive structure under Arteta has conceded only 3 goals across 8 UCL games this season.\n\nThe absence of Vinicius Jr is the pivotal variable. If he plays, Madrid's win probability rises to ~62%. If he doesn't start, it drops to ~48%. Current reports suggest he will be on the bench at best. Predicted probability of a Madrid home win: 52–56%."),
                PredictionCard(question: "Will Arsenal score away at the Bernabéu?",
                               imageURL: "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800&q=80",
                               daysLeft: 3, yesPercent: 61, noPercent: 39, totalVotes: 12300,
                               aiAnalysis: "Arsenal have scored in every away match in this Champions League campaign. Bukayo Saka and Martin Ødegaard have combined for 14 goals and assists in European play this season.\n\nHistorically, teams with an unbeaten European record in a given season score in their away semi-final leg 73% of the time. Probability of Arsenal scoring: 60–65%."),
                PredictionCard(question: "Will Arsenal reach the Champions League final?",
                               imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
                               daysLeft: 10, yesPercent: 49, noPercent: 51, totalVotes: 9800,
                               aiAnalysis: "On paper, this is the most evenly-matched semi-final in a decade. Arsenal's xG differential in the competition is +21.3, fractionally ahead of Madrid's +19.7. The tie will likely be decided by individual moments of quality rather than tactical superiority.\n\nProbability of Arsenal advancing to the final over both legs: 47–52%. Essentially a coin flip.")
            ]
        )

        // Science 1 — Mars water
        let mars = scienceNews[0]
        dict[mars.id] = Article(
            newsItem: mars,
            keyFacts: [
                KeyFact(emoji: "💧", text: "30km wide brine lake"),
                KeyFact(emoji: "📡", text: "Detected by MAVEN-2 radar"),
                KeyFact(emoji: "🌡️", text: "Temp: -20°C, salt-saturated"),
                KeyFact(emoji: "🧊", text: "1.5km below surface ice")
            ],
            bodyParagraphs: [
                .text(UUID(), "Scientists at NASA's Jet Propulsion Laboratory confirmed Tuesday that MAVEN-2's shallow radar instrument has detected a coherent reflector 1.5 kilometres beneath the Martian south polar layered deposits consistent with a body of liquid water spanning approximately 30 kilometres in width. The finding, published in Nature Astronomy, represents the most significant discovery of accessible Martian water to date."),
                .image(UUID(), "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80", "Mars south pole as imaged by ESA's Mars Express — the reservoir lies beneath this region"),
                .text(UUID(), "The water is likely a highly saline brine, similar to subglacial lakes found beneath the Antarctic ice sheets where microbial life thrives in near-total darkness. The salt concentration, estimated at 20–25%, lowers the freezing point enough to maintain liquid water despite Martian surface temperatures. Astrobiologists note that perchlorate-tolerant bacteria discovered in Chile's Atacama Desert have demonstrated viability in analogous chemical conditions.")
            ],
            predictionQuestions: [
                PredictionCard(question: "Will a future mission detect biosignatures in the Martian brine?",
                               imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
                               daysLeft: 3650, yesPercent: 34, noPercent: 66, totalVotes: 14722,
                               aiAnalysis: "Direct access to the subglacial lake would require a drilling mission — a technology NASA does not have in its current Mars programme pipeline. The earliest such mission could realistically fly is the mid-2030s, with results available in the 2040s.\n\nGiven the extreme salinity, radiation environment, and perchlorate concentrations, the probability of detectable life is genuinely uncertain. Astrobiologists assign roughly 10–20% probability to extant Martian life existing anywhere on the planet; the discovery of this lake raises that estimate modestly. Probability of biosignatures detected within 10 years: 12–18%."),
                PredictionCard(question: "Will NASA announce a dedicated drilling mission to the site?",
                               imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
                               daysLeft: 730, yesPercent: 58, noPercent: 42, totalVotes: 8200,
                               aiAnalysis: "NASA's Mars programme is currently structured around sample return (MSR) and the Artemis lunar commitments. A dedicated drilling mission would require a new budget line — difficult in the current fiscal climate.\n\nHowever, the scientific significance of this discovery creates political momentum. The ESA Cosmic Vision programme has an open slot for a flagship-class mission in the early 2030s, and a joint NASA-ESA proposal is being drafted. Probability of a formal mission announcement within 2 years: 55–62%."),
                PredictionCard(question: "Will this discovery accelerate the Mars crewed mission timeline?",
                               imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
                               daysLeft: 365, yesPercent: 42, noPercent: 58, totalVotes: 6100,
                               aiAnalysis: "SpaceX's Starship programme targets a crewed Mars landing in the early 2030s regardless of this discovery. NASA's Moon-to-Mars architecture doesn't yet have a crewed Mars budget.\n\nThe discovery adds scientific urgency and public interest, which historically translates into Congressional support for funding. However, 'accelerating' a timeline that has already slipped by a decade would require sustained political will that is historically rare. Probability this discovery leads to a measurably earlier crewed mission: 38–44%.")
            ]
        )

        // Fill remaining news items with concise articles
        for item in techNews.dropFirst() + politicsNews + sportsNews.dropFirst() + scienceNews.dropFirst() {
            dict[item.id] = Article(
                newsItem: item,
                keyFacts: defaultKeyFacts(for: item),
                bodyParagraphs: defaultBody(for: item),
                predictionQuestions: defaultPredictions(for: item)
            )
        }

        return dict
    }()

    // MARK: - Helpers for remaining articles

    private static func defaultKeyFacts(for item: NewsItem) -> [KeyFact] {
        [
            KeyFact(emoji: "📰", text: item.source),
            KeyFact(emoji: "⏱️", text: item.timeAgo),
            KeyFact(emoji: "🗳️", text: "\(item.votesCount) голосов"),
            KeyFact(emoji: "🏷️", text: item.category.rawValue)
        ]
    }

    private static func defaultBody(for item: NewsItem) -> [BodyElement] {
        [
            .text(UUID(), item.subtitle),
            .image(UUID(), item.imageURL, "\(item.source) — \(item.timeAgo)"),
            .text(UUID(), "Experts and analysts continue to debate the long-term implications of this development. Multiple stakeholders have weighed in, with opinions divided along predictable lines. The situation is expected to develop rapidly in the coming days and weeks as more data becomes available."),
            .text(UUID(), "Markets, policymakers, and the public are watching closely. Early indicators suggest the impact will be felt across multiple sectors, with downstream effects on related industries and geopolitical relationships. Official statements are expected from key institutions before the end of the week.")
        ]
    }

    private static func defaultPredictions(for item: NewsItem) -> [PredictionCard] {
        let q1 = item.options.first
        let q2 = item.options.last
        return [
            PredictionCard(
                question: item.question,
                imageURL: item.imageURL,
                daysLeft: 14,
                yesPercent: q1.map { $0.percent } ?? 50,
                noPercent: q2.map { $0.percent } ?? 50,
                totalVotes: item.votesCount,
                aiAnalysis: "Based on current data and historical precedent, this outcome has a roughly even probability. Key factors include macroeconomic conditions, political developments, and market sentiment. Analysts remain divided, with estimates ranging from 40% to 60% probability for the primary outcome.\n\nThe near-term catalyst to watch is the response from key institutional players in the next 48–72 hours. Historical parallels from 2022 and 2023 suggest a decisive move is likely rather than prolonged uncertainty."
            ),
            PredictionCard(
                question: "Will this story dominate headlines for more than a week?",
                imageURL: item.imageURL,
                daysLeft: 7,
                yesPercent: 61,
                noPercent: 39,
                totalVotes: item.votesCount / 2,
                aiAnalysis: "High-impact news events in the \(item.category.rawValue) sector typically generate sustained coverage for 7–14 days before being displaced by new developments. Given the stakes involved and the number of affected parties, this story has above-average longevity potential.\n\nSocial media velocity is currently high, with search interest up 340% in the past 24 hours. Probability of sustained 7+ day coverage: 60–65%."
            ),
            PredictionCard(
                question: "Will there be a major follow-up development within 30 days?",
                imageURL: item.imageURL,
                daysLeft: 30,
                yesPercent: 74,
                noPercent: 26,
                totalVotes: item.votesCount / 3,
                aiAnalysis: "Complex situations of this nature rarely resolve cleanly in a single news cycle. Follow-up developments — whether escalations, policy responses, or market reactions — are highly probable within 30 days.\n\nBased on the pattern of similar events, there is approximately a 72–76% probability of at least one significant follow-up development that warrants its own headline coverage."
            )
        ]
    }
}
