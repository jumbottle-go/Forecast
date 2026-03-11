import Foundation

// MARK: - Flash Card Model

struct FlashCard: Identifiable {
    let id: UUID
    let question: String
    let category: String
    let symbol: String
    let imageURL: String
    let votesCount: Int
    let aiShortAnswer: String
    let aiAnalysis: AIAnalysis
}

// MARK: - Mock News Items

enum MockData {

    // MARK: Breaking Hero
    static let breakingHero = NewsItem(
        title: "US-China Trade War Escalates: New 145% Tariffs on Tech Imports",
        subtitle: "Washington imposes sweeping new duties on semiconductors and consumer electronics as Beijing vows immediate retaliation.",
        imageURL: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
        source: "Reuters",
        publishedAt: Date(timeIntervalSinceNow: -840),
        votesCount: 8_412,
        category: .politics,
        isBreaking: true,
        question: "When will China formally retaliate to the new US tariffs?",
        options: [
            VoteOption(iconName: "bolt.fill", text: "Within 48h", subtitle: "Swift response", percent: 62),
            VoteOption(iconName: "bubble.left.and.bubble.right.fill", text: "Negotiations", subtitle: "Diplomacy", percent: 38)
        ],
        aiShortAnswer: "Within 48h",
        aiAnalysis: AIAnalysis(
            summary: "Within 48h",
            confidencePercent: 62,
            prosLabel: "Within 48h",
            consLabel: "Negotiations",
            pros: [
            "In 2018–2019 Beijing responded within 24 hours",
            "China's State Council convened an emergency session",
            "Rare earth restrictions ready to be signed"
            ],
            cons: [
            "Secret diplomatic talks are underway",
            "Beijing may prefer non-tariff pressure"
            ]
        )
    )

    // MARK: Finance
    static let financeNews: [NewsItem] = [
        NewsItem(
            title: "Fed Holds Rates at 4.75% Amid Inflation Uncertainty",
            subtitle: "Powell signals 'wait-and-see' stance as jobs data remains strong and core inflation ticks upward.",
            imageURL: "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=800&q=80",
            source: "Bloomberg",
            publishedAt: Date(timeIntervalSinceNow: -3600),
            votesCount: 4_231,
            category: .finance,
            question: "What will the Fed do with rates before Q3 2026?",
            options: [
                VoteOption(iconName: "arrow.down.circle.fill", text: "Cut", subtitle: "Economic cooling", percent: 44),
                VoteOption(iconName: "lock.fill", text: "Hold", subtitle: "Inflation risk", percent: 56)
            ],
            aiShortAnswer: "Hold",
            aiAnalysis: AIAnalysis(
                summary: "Hold",
                confidencePercent: 56,
                prosLabel: "Hold",
                consLabel: "Cut",
                pros: [
                "Tariffs create inflationary risk",
                "Labour market remains overheated"
                ],
                cons: [
                "Core PCE below 3% since Dec 2025",
                "Historically Fed cuts 2 meetings after peak"
                ]
            )
        ),
        NewsItem(
            title: "Bitcoin Surges Past $128,000 — New All-Time High",
            subtitle: "Institutional demand and ETF inflows push BTC to historic levels, with analysts eyeing $150K next.",
            imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
            source: "CoinDesk",
            publishedAt: Date(timeIntervalSinceNow: -7200),
            votesCount: 12_870,
            category: .finance,
            question: "What's next for Bitcoin in the next 60 days?",
            options: [
                VoteOption(iconName: "arrow.up.circle.fill", text: "$150k+", subtitle: "Trend intact", percent: 58),
                VoteOption(iconName: "arrow.down.circle.fill", text: "Correction", subtitle: "Market overheating", percent: 42)
            ],
            aiShortAnswer: "$150k+",
            aiAnalysis: AIAnalysis(
                summary: "$150k+",
                confidencePercent: 58,
                prosLabel: "$150k+",
                consLabel: "Correction",
                pros: [
                "Post-halving cycle historically peaks in 12–18 months",
                "Record ETF inflow: $3.2B in one week",
                "Stock-to-flow: target $180K–$220K"
                ],
                cons: [
                "Fear & greed index 89/100 — overbought",
                "BTC dominance near historical rotation peak"
                ]
            )
        ),
        NewsItem(
            title: "Nvidia Reports $42B Quarter, Raises Guidance Again",
            subtitle: "Data center revenue soars 122% YoY as demand for AI chips continues to outpace supply globally.",
            imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
            source: "CNBC",
            publishedAt: Date(timeIntervalSinceNow: -10800),
            votesCount: 6_540,
            category: .finance,
            question: "Where will NVDA stock be by the end of 2026?",
            options: [
                VoteOption(iconName: "chart.line.uptrend.xyaxis", text: "$200+", subtitle: "AI boom continues", percent: 71),
                VoteOption(iconName: "chart.bar.fill", text: "Plateau", subtitle: "Competitor pressure", percent: 29)
            ],
            aiShortAnswer: "$200+",
            aiAnalysis: AIAnalysis(
                summary: "$200+",
                confidencePercent: 71,
                prosLabel: "$200+",
                consLabel: "Plateau",
                pros: [
                "Forward P/E 32x — below 3-year avg 40x",
                "GB300 launch in Q3 adds key catalyst",
                "Hyperscalers continue raising capex"
                ],
                cons: [
                "Tariffs raise hardware costs",
                "AMD gaining share in inference workloads"
                ]
            )
        )
    ]

    // MARK: Tech
    static let techNews: [NewsItem] = [
        NewsItem(
            title: "OpenAI Launches GPT-5: Scores 97% on Bar Exam, 'Thinks' in Real-Time",
            subtitle: "The new model demonstrates unprecedented reasoning and multi-step problem solving, raising new alignment concerns.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "The Verge",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 21_050,
            category: .tech,
            question: "How will the EU react to GPT-5 in the next 6 months?",
            options: [
                VoteOption(iconName: "hammer.fill", text: "Ban", subtitle: "Strict measures", percent: 53),
                VoteOption(iconName: "cpu", text: "Integration", subtitle: "Regulators lag behind", percent: 47)
            ],
            aiShortAnswer: "Ban",
            aiAnalysis: AIAnalysis(
                summary: "Ban",
                confidencePercent: 53,
                prosLabel: "Ban",
                consLabel: "Integration",
                pros: [
                "EU AI Act already requires audits for top models",
                "GPT-4 investigation accelerates the process"
                ],
                cons: [
                "Fines within 6 months — historically fast for EU",
                "Big business lobbying slows enforcement"
                ]
            )
        ),
        NewsItem(
            title: "Apple Vision Pro 2 Leaks: 4K Micro-OLED, Half the Weight",
            subtitle: "Internal documents suggest a spring release at $2,499 with a new 'spatial OS' optimized for professional workflows.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "9to5Mac",
            publishedAt: Date(timeIntervalSinceNow: -14400),
            votesCount: 9_103,
            category: .tech,
            question: "First-year sales forecast for Apple Vision Pro 2?",
            options: [
                VoteOption(iconName: "star.fill", text: "> 1M", subtitle: "Lower price", percent: 39),
                VoteOption(iconName: "dollarsign.circle.fill", text: "< 1M", subtitle: "Still niche", percent: 61)
            ],
            aiShortAnswer: "< 1M",
            aiAnalysis: AIAnalysis(
                summary: "< 1M",
                confidencePercent: 61,
                prosLabel: "< 1M",
                consLabel: "> 1M",
                pros: [
                "Any VR headset above $1K remains niche",
                "Meta Quest Pro costs half the price"
                ],
                cons: [
                "Price reduced vs first generation",
                "App ecosystem has grown significantly"
                ]
            )
        ),
        NewsItem(
            title: "Google Achieves Quantum Error Correction Milestone with Willow 2",
            subtitle: "The 1,000-qubit processor solves in minutes what classical supercomputers would need 10²⁵ years for.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "Nature",
            publishedAt: Date(timeIntervalSinceNow: -21600),
            votesCount: 3_782,
            category: .tech,
            question: "Will quantum computing break current encryption by 2030?",
            options: [
                VoteOption(iconName: "lock.open.fill", text: "Break it", subtitle: "Accelerating progress", percent: 35),
                VoteOption(iconName: "shield.fill", text: "Holds up", subtitle: "Crypto protection ready", percent: 65)
            ],
            aiShortAnswer: "Holds up",
            aiAnalysis: AIAnalysis(
                summary: "Holds up",
                confidencePercent: 65,
                prosLabel: "Holds up",
                consLabel: "Break it",
                pros: [
                "Post-quantum cryptography standardized by NIST",
                "Enterprise sector adopting crypto-agility"
                ],
                cons: [
                "Quantum computing progress accelerating",
                "Google Willow: 1000 qubits with record error correction"
                ]
            )
        )
    ]

    // MARK: Politics
    static let politicsNews: [NewsItem] = [
        NewsItem(
            title: "EU Emergency Summit: Member States Agree on €800B Defense Fund",
            subtitle: "European leaders reach historic consensus after months of deadlock, signalling a major shift in continental security policy.",
            imageURL: "https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=800&q=80",
            source: "Politico EU",
            publishedAt: Date(timeIntervalSinceNow: -18000),
            votesCount: 5_329,
            category: .politics,
            question: "Will all 27 EU members ratify the defense fund?",
            options: [
                VoteOption(iconName: "checkmark.seal.fill", text: "Ratify", subtitle: "Common threat", percent: 67),
                VoteOption(iconName: "xmark.circle.fill", text: "Block", subtitle: "Hungarian veto", percent: 33)
            ],
            aiShortAnswer: "Ratify",
            aiAnalysis: AIAnalysis(
                summary: "Ratify",
                confidencePercent: 67,
                prosLabel: "Ratify",
                consLabel: "Block",
                pros: [
                "Trump pressure historically unifies EU",
                "Russia threat — strongest catalyst"
                ],
                cons: [
                "Hungary systematically blocks defense initiatives",
                "Turkish factor complicates consensus"
                ]
            )
        ),
        NewsItem(
            title: "NATO Votes on Georgia & Moldova Accession — Decision Next Week",
            subtitle: "Alliance foreign ministers convene in Brussels as Russia warns of 'red lines' if former Soviet states join.",
            imageURL: "https://images.unsplash.com/photo-1565339852682-03d741248e71?w=800&q=80",
            source: "AP News",
            publishedAt: Date(timeIntervalSinceNow: -28800),
            votesCount: 4_014,
            category: .politics,
            question: "Will Georgia and Moldova join NATO in 2026?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "Accept", subtitle: "Geopolitics", percent: 41),
                VoteOption(iconName: "minus.circle.fill", text: "Delay", subtitle: "Consensus difficulties", percent: 59)
            ],
            aiShortAnswer: "Delay",
            aiAnalysis: AIAnalysis(
                summary: "Delay",
                confidencePercent: 59,
                prosLabel: "Delay",
                consLabel: "Accept",
                pros: [
                "Consensus of all 32 members historically hard to achieve",
                "Elections in Hungary and Slovakia create veto risk"
                ],
                cons: [
                "Geopolitical pressure creates political momentum",
                "US and UK expressed support"
                ]
            )
        ),
        NewsItem(
            title: "UN Security Council Votes on Global AI Governance Treaty",
            subtitle: "China and Russia's expected veto threatens to derail the first international framework for frontier AI systems.",
            imageURL: "https://images.unsplash.com/photo-1562907550-096453ea34f6?w=800&q=80",
            source: "Guardian",
            publishedAt: Date(timeIntervalSinceNow: -36000),
            votesCount: 2_883,
            category: .politics,
            question: "Outcome of the UN Security Council vote on AI Treaty?",
            options: [
                VoteOption(iconName: "doc.fill", text: "Pass", subtitle: "US & EU", percent: 28),
                VoteOption(iconName: "hand.raised.fill", text: "Veto", subtitle: "China & Russia", percent: 72)
            ],
            aiShortAnswer: "Veto",
            aiAnalysis: AIAnalysis(
                summary: "Veto",
                confidencePercent: 72,
                prosLabel: "Veto",
                consLabel: "Pass",
                pros: [
                "China and Russia hold veto power",
                "China is pushing a competing resolution"
                ],
                cons: [
                "US and EU actively lobbying for the treaty",
                "Public pressure after AI incidents is growing"
                ]
            )
        )
    ]

    // MARK: Sports
    static let sportsNews: [NewsItem] = [
        NewsItem(
            title: "Champions League Semi-Finals: Real Madrid vs Arsenal — Who Advances?",
            subtitle: "A classic European clash set for Tuesday; Madrid missing Vinicius, Arsenal unbeaten in the competition this season.",
            imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
            source: "Sky Sports",
            publishedAt: Date(timeIntervalSinceNow: -7200),
            votesCount: 18_440,
            category: .sports,
            question: "Who will reach the Champions League final?",
            options: [
                VoteOption(iconName: "soccerball", text: "Real", subtitle: "Experience & class", percent: 55),
                VoteOption(iconName: "circle.fill", text: "Arsenal", subtitle: "Youthful hunger", percent: 45)
            ],
            aiShortAnswer: "Real",
            aiAnalysis: AIAnalysis(
                summary: "Real",
                confidencePercent: 55,
                prosLabel: "Real",
                consLabel: "Arsenal",
                pros: [
                "18 wins in 22 home European matches",
                "UCL final experience: 15 appearances in club history"
                ],
                cons: [
                "Vinicius Jr. doubtful due to injury",
                "Arsenal kept 3 clean sheets in away matches"
                ]
            )
        ),
        NewsItem(
            title: "F1 2026: New Engine Regs Shake Up the Grid — Ferrari Favourite?",
            subtitle: "Teams complete mandatory homologation tests as analysts suggest the new hybrid power units favour Ferrari's design philosophy.",
            imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
            source: "F1.com",
            publishedAt: Date(timeIntervalSinceNow: -18000),
            votesCount: 7_660,
            category: .sports,
            question: "Who will win the 2026 F1 Constructors' Championship?",
            options: [
                VoteOption(iconName: "car.fill", text: "Ferrari", subtitle: "New regulations", percent: 38),
                VoteOption(iconName: "trophy.fill", text: "Others", subtitle: "Merc/Red Bull", percent: 62)
            ],
            aiShortAnswer: "Ferrari",
            aiAnalysis: AIAnalysis(
                summary: "Others",
                confidencePercent: 62,
                prosLabel: "Others",
                consLabel: "Ferrari",
                pros: [
                "Mercedes and Red Bull developed radical upgrades",
                "Ferrari historically loses points through strategy errors"
                ],
                cons: [
                "2026 engine perfectly suits Ferrari's design philosophy",
                "Leclerc–Hamilton duo — strongest in team history"
                ]
            )
        ),
        NewsItem(
            title: "NBA Trade Deadline Bombshell: LeBron to Warriors in 3-Team Deal",
            subtitle: "The blockbuster trade reunites LeBron James with a championship-calibre roster in what insiders call 'the deal of the decade'.",
            imageURL: "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800&q=80",
            source: "ESPN",
            publishedAt: Date(timeIntervalSinceNow: -3600),
            votesCount: 31_205,
            category: .sports,
            question: "Will the Warriors win the 2026 NBA Championship with LeBron?",
            options: [
                VoteOption(iconName: "star.fill", text: "Champions", subtitle: "Deadly duo", percent: 61),
                VoteOption(iconName: "snowflake", text: "Flop", subtitle: "No chemistry", percent: 39)
            ],
            aiShortAnswer: "Champions",
            aiAnalysis: AIAnalysis(
                summary: "Champions",
                confidencePercent: 61,
                prosLabel: "Champions",
                consLabel: "Flop",
                pros: [
                "LeBron dramatically shifts the Western Conference balance",
                "Curry + LeBron duo — unprecedented in NBA history"
                ],
                cons: [
                "Team chemistry takes time to build",
                "Oklahoma and Denver are also contenders"
                ]
            )
        )
    ]

    // MARK: Science
    static let scienceNews: [NewsItem] = [
        NewsItem(
            title: "NASA Confirms Liquid Water Reservoir Beneath Mars South Pole",
            subtitle: "New radar data from MAVEN-2 reveals a 30km wide brine lake 1.5km below the surface — the largest confirmed body of Martian water.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "NASA JPL",
            publishedAt: Date(timeIntervalSinceNow: -10800),
            votesCount: 14_722,
            category: .science,
            question: "Will microbial life be found in the Martian lake?",
            options: [
                VoteOption(iconName: "sparkles", text: "Found", subtitle: "Suitable environment", percent: 34),
                VoteOption(iconName: "moon.fill", text: "Sterile", subtitle: "Salt & radiation", percent: 66)
            ],
            aiShortAnswer: "Sterile",
            aiAnalysis: AIAnalysis(
                summary: "Sterile",
                confidencePercent: 66,
                prosLabel: "Sterile",
                consLabel: "Found",
                pros: [
                "Drilling mission needed — earliest 2035",
                "Radiation and perchlorates lethal to most organisms"
                ],
                cons: [
                "Conditions similar to Earth's hypersaline environments",
                "Organic molecules already found by rovers"
                ]
            )
        ),
        NewsItem(
            title: "mRNA Cancer Vaccine Shows 93% Efficacy in Phase 3 Trials",
            subtitle: "BioNTech and Moderna's personalised tumour vaccine prevents recurrence in pancreatic and lung cancer patients for 3+ years.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "NEJM",
            publishedAt: Date(timeIntervalSinceNow: -25200),
            votesCount: 9_881,
            category: .science,
            question: "FDA approval decision for the mRNA cancer vaccine in 2026?",
            options: [
                VoteOption(iconName: "syringe.fill", text: "Approve", subtitle: "Phase 3 data", percent: 78),
                VoteOption(iconName: "pause.circle.fill", text: "Delay", subtitle: "More tests needed", percent: 22)
            ],
            aiShortAnswer: "Approve",
            aiAnalysis: AIAnalysis(
                summary: "Approve",
                confidencePercent: 78,
                prosLabel: "Approve",
                consLabel: "Delay",
                pros: [
                "Phase 3 data: 41% mortality reduction",
                "FDA granted Breakthrough Therapy status"
                ],
                cons: [
                "VRBPAC committee may request additional data",
                "Precedents of accelerated approval are controversial"
                ]
            )
        ),
        NewsItem(
            title: "Scientists Confirm Atlantic Circulation (AMOC) Approaching Collapse Threshold",
            subtitle: "New temperature gradient data from 1,200 buoys shows AMOC strength at its lowest point in 1,600 years, accelerating this decade.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "Nature Climate Change",
            publishedAt: Date(timeIntervalSinceNow: -32400),
            votesCount: 6_103,
            category: .science,
            question: "Will the AMOC ocean current fully collapse before 2100?",
            options: [
                VoteOption(iconName: "water.waves", text: "Collapse", subtitle: "Trends are relentless", percent: 47),
                VoteOption(iconName: "leaf.fill", text: "Holds", subtitle: "CO2 decline will help", percent: 53)
            ],
            aiShortAnswer: "Holds",
            aiAnalysis: AIAnalysis(
                summary: "Holds",
                confidencePercent: 53,
                prosLabel: "Holds",
                consLabel: "Collapse",
                pros: [
                "CO2 emission reductions may stabilize the current",
                "Climate models show high uncertainty"
                ],
                cons: [
                "AMOC speed at historical low for 1600 years",
                "Greenland ice melt accelerating faster than projected"
                ]
            )
        )
    ]

    // MARK: Flash Cards

    static let flashNews: [NewsItem] = [
        NewsItem(
            title: "Will S&P 500 close green today?",
            subtitle: "S&P futures rising this morning",
            imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
            source: "Daily Flash",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 3_240,
            category: .finance,
            question: "Will S&P 500 close green today?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "YES", subtitle: "", percent: 61),
                VoteOption(iconName: "xmark.circle.fill",    text: "NO",  subtitle: "", percent: 39)
            ],
            aiShortAnswer: "Green",
            aiAnalysis: AIAnalysis(
                summary: "Green",
                confidencePercent: 61,
                prosLabel: "YES",
                consLabel: "NO",
                pros: ["S&P futures rising this morning", "Fed won't raise rates"],
                cons: ["Geopolitical tension weighing on sentiment", "Trading volume below average"]
            )
        ),
        NewsItem(
            title: "Will Arsenal win tonight?",
            subtitle: "Arsenal unbeaten at home for 11 matches",
            imageURL: "https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=800&q=80",
            source: "Daily Flash",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 7_815,
            category: .sports,
            question: "Will Arsenal win tonight?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "YES", subtitle: "", percent: 58),
                VoteOption(iconName: "xmark.circle.fill",    text: "NO",  subtitle: "", percent: 42)
            ],
            aiShortAnswer: "Win",
            aiAnalysis: AIAnalysis(
                summary: "Win",
                confidencePercent: 58,
                prosLabel: "YES",
                consLabel: "NO",
                pros: ["Arsenal unbeaten at home for 11 matches", "Opponent missing key players"],
                cons: ["Fatigue after away run", "Historically poor in cup games"]
            )
        ),
        NewsItem(
            title: "Will BTC touch $130k today?",
            subtitle: "Target still >8% away in one day",
            imageURL: "https://images.unsplash.com/photo-1518544866330-4e716499f800?w=800&q=80",
            source: "Daily Flash",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 14_520,
            category: .finance,
            question: "Will BTC touch $130k today?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "YES", subtitle: "", percent: 26),
                VoteOption(iconName: "xmark.circle.fill",    text: "NO",  subtitle: "", percent: 74)
            ],
            aiShortAnswer: "Too early",
            aiAnalysis: AIAnalysis(
                summary: "Won't reach",
                confidencePercent: 74,
                prosLabel: "NO",
                consLabel: "YES",
                pros: ["Target still >8% away in one day", "Strong resistance at $125k"],
                cons: ["Institutional demand steadily rising", "ETF inflows exceeded $2B this week"]
            )
        ),
        NewsItem(
            title: "Will Apple announce Vision Pro 2 this week?",
            subtitle: "Apple hasn't announced an event",
            imageURL: "https://images.unsplash.com/photo-1617802690992-15d93263d3a9?w=800&q=80",
            source: "Daily Flash",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 5_103,
            category: .tech,
            question: "Will Apple announce Vision Pro 2 this week?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "YES", subtitle: "", percent: 18),
                VoteOption(iconName: "xmark.circle.fill",    text: "NO",  subtitle: "", percent: 82)
            ],
            aiShortAnswer: "Not this week",
            aiAnalysis: AIAnalysis(
                summary: "No announcement",
                confidencePercent: 82,
                prosLabel: "NO",
                consLabel: "YES",
                pros: ["Apple hasn't announced an event", "Production cycle not yet complete"],
                cons: ["Reliable insider rumours have intensified", "Competitors have already released alternatives"]
            )
        ),
        NewsItem(
            title: "Will EUR/USD stay above 1.09 at close?",
            subtitle: "ECB maintains hawkish rhetoric",
            imageURL: "https://images.unsplash.com/photo-1620321023374-d1a68fbc720d?w=800&q=80",
            source: "Daily Flash",
            publishedAt: Date(timeIntervalSinceNow: -1800),
            votesCount: 2_890,
            category: .finance,
            question: "Will EUR/USD stay above 1.09 at close?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "YES", subtitle: "", percent: 66),
                VoteOption(iconName: "xmark.circle.fill",    text: "NO",  subtitle: "", percent: 34)
            ],
            aiShortAnswer: "Yes, above",
            aiAnalysis: AIAnalysis(
                summary: "Above 1.09",
                confidencePercent: 66,
                prosLabel: "YES",
                consLabel: "NO",
                pros: ["ECB maintains hawkish rhetoric", "Weak US jobs report"],
                cons: ["Dollar strengthening on tariff risks", "Pair technically at key support"]
            )
        )
    ]

    static var flashCards: [FlashCard] {
        flashNews.map { news in
            FlashCard(
                id: news.id,
                question: news.question,
                category: news.category.rawValue,
                symbol: news.category.symbol,
                imageURL: news.imageURL,
                votesCount: news.votesCount,
                aiShortAnswer: news.aiShortAnswer ?? "",
                aiAnalysis: news.aiAnalysis!
            )
        }
    }

    // MARK: All news (excluding hero)
    static var allNews: [NewsItem] {
        financeNews + techNews + politicsNews + sportsNews + scienceNews + flashNews
    }

    // MARK: Articles
    static var articles: [UUID: Article] = {
        var dict: [UUID: Article] = [:]

        // Breaking article
        let breakingArticle = Article(
            newsItem: breakingHero,
            keyFacts: [
                KeyFact(emoji: "percent",                       text: "145% tariff on chips"),
                KeyFact(emoji: "dollarsign.circle.fill",         text: "$380B trade volume at risk"),
                KeyFact(emoji: "exclamationmark.triangle.fill",  text: "TSMC supply chains affected"),
                KeyFact(emoji: "flag.fill",                      text: "Beijing: 'firm countermeasures'"),
                KeyFact(emoji: "chart.line.downtrend.xyaxis",    text: "Nasdaq -3.2% on open")
            ],
            bodyParagraphs: [
                .text(UUID(), "The White House announced Monday a sweeping tariff package targeting Chinese technology imports, covering semiconductors, smartphones, laptops, and advanced manufacturing equipment. The 145% rate — nearly double the previous ceiling — takes effect Friday, giving importers less than 96 hours to adjust supply chains."),
                .image(UUID(), "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80", "U.S. goods trade deficit with China, 2019–2025"),
                .text(UUID(), "China's Ministry of Commerce described the move as 'economic bullying' and called an emergency session of the State Council. Officials hinted at restricting rare earth exports and suspending Boeing aircraft deliveries — moves that would send shockwaves through aerospace and EV supply chains globally."),
                .text(UUID(), "Markets reacted immediately. The Philadelphia Semiconductor Index fell 4.8% while the yuan weakened to 7.42 per dollar. Analysts at Goldman Sachs raised their recession probability estimate for the U.S. to 35% for 2026, citing cascading supply-chain disruptions as the primary risk channel."),
                .image(UUID(), "https://images.unsplash.com/photo-1565339852682-03d741248e71?w=800&q=80", "Cargo containers at the Port of Los Angeles — the busiest U.S. entry point for Chinese goods")
            ]
        )
        dict[breakingHero.id] = breakingArticle

        // Finance 1 — Fed rates
        let fed = financeNews[0]
        dict[fed.id] = Article(
            newsItem: fed,
            keyFacts: [
                KeyFact(emoji: "lock.fill",                  text: "Rate: 4.75% unchanged"),
                KeyFact(emoji: "chart.line.uptrend.xyaxis", text: "Core CPI: 3.1% YoY"),
                KeyFact(emoji: "person.2.fill",              text: "Unemployment: 3.8%"),
                KeyFact(emoji: "building.columns.fill",      text: "2 cuts priced in 2026")
            ],
            bodyParagraphs: [
                .text(UUID(), "The Federal Open Market Committee voted unanimously to hold the benchmark federal funds rate at 4.75–5.00%, matching market expectations. Chair Jerome Powell struck a cautious tone at the press conference, emphasising that the committee needs 'greater confidence' that inflation is sustainably moving toward its 2% target before reducing rates."),
                .image(UUID(), "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=800&q=80", "Federal Reserve headquarters, Washington D.C."),
                .text(UUID(), "The decision comes against a backdrop of resilient consumer spending and a labour market that has defied predictions of cooling. Nonfarm payrolls added 203,000 jobs in February — above the 180,000 consensus — while the unemployment rate held at 3.8%. Core PCE, the Fed's preferred inflation gauge, printed at 2.8% for January, still above target."),
                .text(UUID(), "Fed Funds futures markets now price in a 55% probability of a first cut in July, down from 72% before the meeting. Two rate cuts by year-end remain the base case for Goldman Sachs and JPMorgan, though both institutions flagged tariff-driven inflation as the primary upside risk to the price level.")
            ]
        )

        // Finance 2 — Bitcoin
        let btc = financeNews[1]
        dict[btc.id] = Article(
            newsItem: btc,
            keyFacts: [
                KeyFact(emoji: "bitcoinsign.circle.fill",  text: "Price: $128,400"),
                KeyFact(emoji: "arrow.down.circle.fill",   text: "$3.2B ETF inflows this week"),
                KeyFact(emoji: "building.columns.fill",    text: "BlackRock holds 312K BTC"),
                KeyFact(emoji: "clock.arrow.circlepath",   text: "Halving: 14 months ago")
            ],
            bodyParagraphs: [
                .text(UUID(), "Bitcoin surged past $128,000 for the first time on Tuesday, driven by record weekly inflows into spot Bitcoin ETFs and growing institutional allocation from sovereign wealth funds. The move extends a rally that began in mid-January following the approval of a BTC strategic reserve by the U.S. government."),
                .image(UUID(), "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80", "Bitcoin price chart — the new all-time high breached $128K"),
                .text(UUID(), "BlackRock's iShares Bitcoin Trust (IBIT) alone absorbed $1.4 billion in a single session, the largest single-day inflow since its launch. On-chain data shows long-term holder supply at a 3-year high, suggesting most selling pressure is exhausted. The fear and greed index sits at 89 — 'extreme greed' — a level historically followed by short-term consolidation.")
            ]
        )

        // Finance 3 — Nvidia
        let nvda = financeNews[2]
        dict[nvda.id] = Article(
            newsItem: nvda,
            keyFacts: [
                KeyFact(emoji: "dollarsign.circle.fill",      text: "Revenue: $42.1B (+122% YoY)"),
                KeyFact(emoji: "desktopcomputer",             text: "Data center: $35.8B"),
                KeyFact(emoji: "chart.bar.fill",              text: "EPS: $0.89 vs $0.84 est."),
                KeyFact(emoji: "arrow.up.right.circle.fill",  text: "Q2 guide: $45B+")
            ],
            bodyParagraphs: [
                .text(UUID(), "Nvidia reported fiscal Q4 2026 revenue of $42.1 billion, smashing analyst estimates of $38.2 billion and delivering its eighth consecutive quarter of triple-digit year-over-year data center growth. CEO Jensen Huang described demand as 'insatiable', pointing to the global build-out of AI inference infrastructure as an accelerating rather than decelerating force."),
                .image(UUID(), "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80", "Nvidia H200 GPU cluster — now shipping to hyperscalers globally"),
                .text(UUID(), "The Blackwell architecture, which powers the company's flagship H200 and B100 chips, saw production yields improve significantly in Q4, allowing Nvidia to ramp shipments faster than anticipated. The company also unveiled the GB300 'Blackwell Ultra' roadmap for Q3 2026, promising 2x performance per watt — a development that left AMD and Intel's AI roadmaps looking increasingly distant.")
            ]
        )

        // Tech 1 — GPT-5
        let gpt = techNews[0]
        dict[gpt.id] = Article(
            newsItem: gpt,
            keyFacts: [
                KeyFact(emoji: "brain.head.profile",  text: "97% Bar Exam score"),
                KeyFact(emoji: "bolt.fill",           text: "10x faster than GPT-4"),
                KeyFact(emoji: "globe",               text: "Supports 50 languages"),
                KeyFact(emoji: "sparkles",            text: "Passes PhD-level science evals")
            ],
            bodyParagraphs: [
                .text(UUID(), "OpenAI released GPT-5 to ChatGPT Plus and API customers simultaneously, describing it as 'the first model to demonstrate genuine multi-step reasoning in real time'. In benchmark testing, GPT-5 scored 97th percentile on the LSAT, 94th on the USMLE medical board exam, and achieved a perfect score on the International Mathematical Olympiad qualifier for the first time by any AI system."),
                .image(UUID(), "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80", "GPT-5 benchmark comparison — significantly ahead across reasoning tasks"),
                .text(UUID(), "The model introduces 'chain-of-thought streaming' — users can watch the model reason step-by-step in real time before delivering answers. Safety evaluations revealed GPT-5 scored in the 'high risk' tier on three out of fifteen categories in METR's autonomy evaluations, prompting OpenAI to apply additional output restrictions not present in the research preview.")
            ]
        )

        // Sports 1 — Champions League
        let cl = sportsNews[0]
        dict[cl.id] = Article(
            newsItem: cl,
            keyFacts: [
                KeyFact(emoji: "sportscourt.fill",  text: "Venue: Santiago Bernabéu"),
                KeyFact(emoji: "soccerball",        text: "Arsenal: unbeaten in UCL"),
                KeyFact(emoji: "stethoscope",       text: "Vinicius: doubtful (hamstring)"),
                KeyFact(emoji: "clock.fill",        text: "Kick-off: 21:00 CET Tuesday")
            ],
            bodyParagraphs: [
                .text(UUID(), "Real Madrid host Arsenal in the first leg of a hotly anticipated Champions League semi-final that has captivated European football fans. Arsenal, managed by Mikel Arteta, arrive in Madrid unbeaten in the competition — winning all eight group and knockout stage matches — while Real Madrid are seeking their fourth Champions League title in eight seasons."),
                .image(UUID(), "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80", "The Bernabéu under floodlights — site of countless European nights"),
                .text(UUID(), "The tie is delicately poised given Vinicius Jr's injury doubt. The Brazilian winger has been directly involved in 19 Champions League goals over the past two seasons. Without him, Madrid's attacking threat diminishes significantly, potentially favouring Arsenal's high-intensity pressing game which has dismantled every opponent it has faced this campaign.")
            ]
        )

        // Science 1 — Mars water
        let mars = scienceNews[0]
        dict[mars.id] = Article(
            newsItem: mars,
            keyFacts: [
                KeyFact(emoji: "drop.fill",                          text: "30km wide brine lake"),
                KeyFact(emoji: "antenna.radiowaves.left.and.right",   text: "Detected by MAVEN-2 radar"),
                KeyFact(emoji: "thermometer",                         text: "Temp: -20°C, salt-saturated"),
                KeyFact(emoji: "snowflake",                           text: "1.5km below surface ice")
            ],
            bodyParagraphs: [
                .text(UUID(), "Scientists at NASA's Jet Propulsion Laboratory confirmed Tuesday that MAVEN-2's shallow radar instrument has detected a coherent reflector 1.5 kilometres beneath the Martian south polar layered deposits consistent with a body of liquid water spanning approximately 30 kilometres in width. The finding, published in Nature Astronomy, represents the most significant discovery of accessible Martian water to date."),
                .image(UUID(), "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80", "Mars south pole as imaged by ESA's Mars Express — the reservoir lies beneath this region"),
                .text(UUID(), "The water is likely a highly saline brine, similar to subglacial lakes found beneath the Antarctic ice sheets where microbial life thrives in near-total darkness. The salt concentration, estimated at 20–25%, lowers the freezing point enough to maintain liquid water despite Martian surface temperatures. Astrobiologists note that perchlorate-tolerant bacteria discovered in Chile's Atacama Desert have demonstrated viability in analogous chemical conditions.")
            ]
        )

        // Fill remaining news items with concise articles
        for item in techNews.dropFirst() + politicsNews + sportsNews.dropFirst() + scienceNews.dropFirst() {
            dict[item.id] = Article(
                newsItem: item,
                keyFacts: defaultKeyFacts(for: item),
                bodyParagraphs: defaultBody(for: item)
            )
        }

        // Flash articles
        for item in flashNews {
            dict[item.id] = Article(
                newsItem: item,
                keyFacts: defaultKeyFacts(for: item),
                bodyParagraphs: defaultBody(for: item)
            )
        }

        return dict
    }()

    // MARK: - Helpers for remaining articles

    private static func defaultKeyFacts(for item: NewsItem) -> [KeyFact] {
        [
            KeyFact(emoji: "newspaper.fill",  text: item.source),
            KeyFact(emoji: "clock.fill",      text: item.timeAgo),
            KeyFact(emoji: "person.2.fill",   text: "\(item.votesCount) votes"),
            KeyFact(emoji: "tag.fill",        text: item.category.rawValue)
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
}
