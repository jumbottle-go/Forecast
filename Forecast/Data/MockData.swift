import Foundation

// MARK: - Flash Card Model

struct FlashCard: Identifiable {
    let id: UUID
    let question: String
    let category: String
    let symbol: String
    let imageURL: String
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
        timeAgo: "14 мин.",
        votesCount: 8_412,
        category: .politics,
        isBreaking: true,
        question: "When will China formally retaliate to the new US tariffs?",
        options: [
            VoteOption(iconName: "bolt.fill", text: "За 48ч", subtitle: "Резкий ответ", percent: 62),
            VoteOption(iconName: "bubble.left.and.bubble.right.fill", text: "Переговоры", subtitle: "Дипломатия", percent: 38)
        ],
        aiShortAnswer: "За 48ч",
        aiAnalysis: AIAnalysis(
            summary: "62% за «За 48ч»",
            pros: [
            "В 2018–2019 гг. Пекин отвечал в течение 24 ч.",
            "Госсовет КНР созвал экстренное заседание",
            "Ограничения на редкозёмы готовы к подписанию"
            ],
            cons: [
            "Идут тайные дипломатические переговоры",
            "Пекин может предпочесть нетарифное давление"
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
            timeAgo: "1 ч.",
            votesCount: 4_231,
            category: .finance,
            question: "What will the Fed do with rates before Q3 2026?",
            options: [
                VoteOption(iconName: "arrow.down.circle.fill", text: "Снизит", subtitle: "Охлаждение экономики", percent: 44),
                VoteOption(iconName: "lock.fill", text: "Заморозит", subtitle: "Риск инфляции", percent: 56)
            ],
                aiShortAnswer: "Заморозит",
            aiAnalysis: AIAnalysis(
                summary: "56% за «Заморозит»",
                pros: [
                "Тарифы создают инфляционный риск",
                "Рынок труда остаётся перегретым"
                ],
                cons: [
                "Core PCE ниже 3% с декабря 2025",
                "Исторически ФРС снижает через 2 заседания после пика"
                ]
            )
        ),
        NewsItem(
            title: "Bitcoin Surges Past $128,000 — New All-Time High",
            subtitle: "Institutional demand and ETF inflows push BTC to historic levels, with analysts eyeing $150K next.",
            imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
            source: "CoinDesk",
            timeAgo: "2 ч.",
            votesCount: 12_870,
            category: .finance,
            question: "What's next for Bitcoin in the next 60 days?",
            options: [
                VoteOption(iconName: "arrow.up.circle.fill", text: "$150k+", subtitle: "Тенденция в силе", percent: 58),
                VoteOption(iconName: "arrow.down.circle.fill", text: "Коррекция", subtitle: "Перегрев рынка", percent: 42)
            ],
            aiShortAnswer: "$150k+",
            aiAnalysis: AIAnalysis(
                summary: "58% за «$150k+»",
                pros: [
                "Post-halving цикл исторически пиковый через 12–18 мес.",
                "Рекордный приток в ETF: $3.2B за неделю",
                "Stock-to-flow: цель $180K–$220K"
                ],
                cons: [
                "Индикатор жадности 89/100 — перекупленность",
                "BTC-доминация вблизи исторического ротационного пика"
                ]
            )
        ),
        NewsItem(
            title: "Nvidia Reports $42B Quarter, Raises Guidance Again",
            subtitle: "Data center revenue soars 122% YoY as demand for AI chips continues to outpace supply globally.",
            imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80",
            source: "CNBC",
            timeAgo: "3 ч.",
            votesCount: 6_540,
            category: .finance,
            question: "Where will NVDA stock be by the end of 2026?",
            options: [
                VoteOption(iconName: "chart.line.uptrend.xyaxis", text: "$200+", subtitle: "ИИ-бум продолжается", percent: 71),
                VoteOption(iconName: "chart.bar.fill", text: "Плато", subtitle: "Давление конкурентов", percent: 29)
            ],
            aiShortAnswer: "$200+",
            aiAnalysis: AIAnalysis(
                summary: "71% за «$200+»",
                pros: [
                "Форвардный P/E 32x — ниже 3-летнего среднего 40x",
                "Запуск GB300 в Q3 добавит ключевой катализатор",
                "Гиперскейлеры продолжают наращивать капзатраты"
                ],
                cons: [
                "Тарифы повышают стоимость аппаратного обеспечения",
                "AMD набирает долю рынка в инференс-нагрузках"
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
            timeAgo: "30 мин.",
            votesCount: 21_050,
            category: .tech,
            question: "How will the EU react to GPT-5 in the next 6 months?",
            options: [
                VoteOption(iconName: "hammer.fill", text: "Запрет", subtitle: "Жёсткие меры", percent: 53),
                VoteOption(iconName: "cpu", text: "Интеграция", subtitle: "Регуляторы отстают", percent: 47)
            ],
            aiShortAnswer: "Запрет",
            aiAnalysis: AIAnalysis(
                summary: "53% за «Запрет»",
                pros: [
                "EU AI Act уже требует аудита для топ-моделей",
                "Расследование GPT-4 ускоряет процесс"
                ],
                cons: [
                "Штрафы за 6 мес. — исторически быстро для ЕС",
                "Лоббирование крупного бизнеса тормозит исполнение"
                ]
            )
        ),
        NewsItem(
            title: "Apple Vision Pro 2 Leaks: 4K Micro-OLED, Half the Weight",
            subtitle: "Internal documents suggest a spring release at $2,499 with a new 'spatial OS' optimized for professional workflows.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "9to5Mac",
            timeAgo: "4 ч.",
            votesCount: 9_103,
            category: .tech,
            question: "First-year sales forecast for Apple Vision Pro 2?",
            options: [
                VoteOption(iconName: "star.fill", text: "> 1 млн", subtitle: "Сниженная цена", percent: 39),
                VoteOption(iconName: "dollarsign.circle.fill", text: "< 1 млн", subtitle: "Всё ещё ниша", percent: 61)
            ],
            aiShortAnswer: "< 1 млн",
            aiAnalysis: AIAnalysis(
                summary: "61% за «< 1 млн»",
                pros: [
                "Любая VR-гарнитура выше $1K остаётся нишевой",
                "Meta Quest Pro стоит вдвое дешевле"
                ],
                cons: [
                "Цена снижена vs первого поколения",
                "Экосистема приложений значительно расширилась"
                ]
            )
        ),
        NewsItem(
            title: "Google Achieves Quantum Error Correction Milestone with Willow 2",
            subtitle: "The 1,000-qubit processor solves in minutes what classical supercomputers would need 10²⁵ years for.",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80",
            source: "Nature",
            timeAgo: "6 ч.",
            votesCount: 3_782,
            category: .tech,
            question: "Will quantum computing break current encryption by 2030?",
            options: [
                VoteOption(iconName: "lock.open.fill", text: "Взломают", subtitle: "Ускорение прогресса", percent: 35),
                VoteOption(iconName: "shield.fill", text: "Устоят", subtitle: "Крипто-защита готова", percent: 65)
            ],
            aiShortAnswer: "Устоят",
            aiAnalysis: AIAnalysis(
                summary: "65% за «Устоят»",
                pros: [
                "Post-quantum криграфия стандартизирована NIST",
                "Корпоративный сектор внедряет крипто-агильность"
                ],
                cons: [
                "Темп развития квантовых вычислений ускоряется",
                "Google Willow: 1000 кубитов с рекордной коррекцией"
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
            timeAgo: "5 ч.",
            votesCount: 5_329,
            category: .politics,
            question: "Will all 27 EU members ratify the defense fund?",
            options: [
                VoteOption(iconName: "checkmark.seal.fill", text: "Ратифицируют", subtitle: "Общая угроза", percent: 67),
                VoteOption(iconName: "xmark.circle.fill", text: "Заблокируют", subtitle: "Венгерское вето", percent: 33)
            ],
            aiShortAnswer: "Ратифицируют",
            aiAnalysis: AIAnalysis(
                summary: "67% за «Ратифицируют»",
                pros: [
                "Давление Трампа исторически объединяет ЕС",
                "Угроза со стороны РФ — сильнейший катализатор"
                ],
                cons: [
                "Венгрия систематически блокирует оборонные инициативы",
                "Турецкий фактор усложняет консенсус"
                ]
            )
        ),
        NewsItem(
            title: "NATO Votes on Georgia & Moldova Accession — Decision Next Week",
            subtitle: "Alliance foreign ministers convene in Brussels as Russia warns of 'red lines' if former Soviet states join.",
            imageURL: "https://images.unsplash.com/photo-1565339852682-03d741248e71?w=800&q=80",
            source: "AP News",
            timeAgo: "8 ч.",
            votesCount: 4_014,
            category: .politics,
            question: "Will Georgia and Moldova join NATO in 2026?",
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "Примут", subtitle: "Геополитика", percent: 41),
                VoteOption(iconName: "minus.circle.fill", text: "Отложат", subtitle: "Сложности консенсуса", percent: 59)
            ],
            aiShortAnswer: "Отложат",
            aiAnalysis: AIAnalysis(
                summary: "59% за «Отложат»",
                pros: [
                "Консенсус всех 32 членов исторически труднодостижим",
                "Выборы в Венгрии и Словакии создают риск вето"
                ],
                cons: [
                "Геополитическое давление создаёт политический импульс",
                "США и Великобритания выразили поддержку"
                ]
            )
        ),
        NewsItem(
            title: "UN Security Council Votes on Global AI Governance Treaty",
            subtitle: "China and Russia's expected veto threatens to derail the first international framework for frontier AI systems.",
            imageURL: "https://images.unsplash.com/photo-1562907550-096453ea34f6?w=800&q=80",
            source: "Guardian",
            timeAgo: "10 ч.",
            votesCount: 2_883,
            category: .politics,
            question: "Outcome of the UN Security Council vote on AI Treaty?",
            options: [
                VoteOption(iconName: "doc.fill", text: "Примут", subtitle: "США и ЕС", percent: 28),
                VoteOption(iconName: "hand.raised.fill", text: "Вето", subtitle: "Китай и РФ", percent: 72)
            ],
            aiShortAnswer: "Вето",
            aiAnalysis: AIAnalysis(
                summary: "72% за «Вето»",
                pros: [
                "Китай и Россия обладают правом вето",
                "КНР продвигает конкурирующую резолюцию"
                ],
                cons: [
                "США и ЕС активно лоббируют договор",
                "Общественное давление после инцидентов с ИИ растёт"
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
            timeAgo: "2 ч.",
            votesCount: 18_440,
            category: .sports,
            question: "Who will reach the Champions League final?",
            options: [
                VoteOption(iconName: "soccerball", text: "Реал", subtitle: "Опыт и класс", percent: 55),
                VoteOption(iconName: "circle.fill", text: "Арсенал", subtitle: "Молодая злость", percent: 45)
            ],
            aiShortAnswer: "Реал",
            aiAnalysis: AIAnalysis(
                summary: "55% за «Реал»",
                pros: [
                "18 побед в 22 домашних еврокубковых матчах",
                "Опыт финалов ЛЧ: 15 участий за историю клуба"
                ],
                cons: [
                "Виньисиус Жр. под сомнением из-за травмы",
                "Арсенал не пропустил гола в 3 гостевых матчах"
                ]
            )
        ),
        NewsItem(
            title: "F1 2026: New Engine Regs Shake Up the Grid — Ferrari Favourite?",
            subtitle: "Teams complete mandatory homologation tests as analysts suggest the new hybrid power units favour Ferrari's design philosophy.",
            imageURL: "https://images.unsplash.com/photo-1461896836934-bd45ba0c5530?w=800&q=80",
            source: "F1.com",
            timeAgo: "5 ч.",
            votesCount: 7_660,
            category: .sports,
            question: "Who will win the 2026 F1 Constructors' Championship?",
            options: [
                VoteOption(iconName: "car.fill", text: "Ferrari", subtitle: "Новый регламент", percent: 38),
                VoteOption(iconName: "trophy.fill", text: "Другие", subtitle: "Merc/Red Bull", percent: 62)
            ],
            aiShortAnswer: "Ferrari",
            aiAnalysis: AIAnalysis(
                summary: "62% за «Другие»",
                pros: [
                "Mercedes и Red Bull разработали кардинальные обновления",
                "Феррари исторически теряет очки из-за ошибок стратегии"
                ],
                cons: [
                "Новый двигатель 2026 идеально соответствует стилю Феррари",
                "Дуэт Леклер–Хэмилтон — сильнейший за историю команды"
                ]
            )
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
                VoteOption(iconName: "star.fill", text: "Чемпионы", subtitle: "Убойный дуэт", percent: 61),
                VoteOption(iconName: "snowflake", text: "Провал", subtitle: "Нет химии", percent: 39)
            ],
            aiShortAnswer: "Чемпионы",
            aiAnalysis: AIAnalysis(
                summary: "61% за «Чемпионы»",
                pros: [
                "ЛеБрон кардинально меняет баланс сил на Западе",
                "Дуэт Карри + ЛеБрон — беспрецедентный в истории НБА"
                ],
                cons: [
                "Командная химия требует времени на построение",
                "Оклахома и Денвер также являются претендентами"
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
            timeAgo: "3 ч.",
            votesCount: 14_722,
            category: .science,
            question: "Will microbial life be found in the Martian lake?",
            options: [
                VoteOption(iconName: "sparkles", text: "Найдут", subtitle: "Подходящая среда", percent: 34),
                VoteOption(iconName: "moon.fill", text: "Стерильно", subtitle: "Соль и радиация", percent: 66)
            ],
            aiShortAnswer: "Стерильно",
            aiAnalysis: AIAnalysis(
                summary: "66% за «Стерильно»",
                pros: [
                "Нужна буровая миссия — не ранее 2035 г.",
                "Радиация и перхлораты губительны для большинства организмов"
                ],
                cons: [
                "Условия схожи с земными гипергалинными средами",
                "Органические молекулы уже найдены марсоходами"
                ]
            )
        ),
        NewsItem(
            title: "mRNA Cancer Vaccine Shows 93% Efficacy in Phase 3 Trials",
            subtitle: "BioNTech and Moderna's personalised tumour vaccine prevents recurrence in pancreatic and lung cancer patients for 3+ years.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "NEJM",
            timeAgo: "7 ч.",
            votesCount: 9_881,
            category: .science,
            question: "FDA approval decision for the mRNA cancer vaccine in 2026?",
            options: [
                VoteOption(iconName: "syringe.fill", text: "Одобрение", subtitle: "Данные Phase 3", percent: 78),
                VoteOption(iconName: "pause.circle.fill", text: "Задержка", subtitle: "Нужны доп. тесты", percent: 22)
            ],
            aiShortAnswer: "Одобрение",
            aiAnalysis: AIAnalysis(
                summary: "78% за «Одобрение»",
                pros: [
                "Данные Phase 3: снижение смертности на 41%",
                "FDA предоставило статус прорывной терапии"
                ],
                cons: [
                "Комитет VRBPAC может запросить дополнительные данные",
                "Прецеденты ускоренного одобрения вызывают споры"
                ]
            )
        ),
        NewsItem(
            title: "Scientists Confirm Atlantic Circulation (AMOC) Approaching Collapse Threshold",
            subtitle: "New temperature gradient data from 1,200 buoys shows AMOC strength at its lowest point in 1,600 years, accelerating this decade.",
            imageURL: "https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&q=80",
            source: "Nature Climate Change",
            timeAgo: "9 ч.",
            votesCount: 6_103,
            category: .science,
            question: "Will the AMOC ocean current fully collapse before 2100?",
            options: [
                VoteOption(iconName: "water.waves", text: "Коллапс", subtitle: "Тренды неумолимы", percent: 47),
                VoteOption(iconName: "leaf.fill", text: "Выстоит", subtitle: "Поможет спад CO2", percent: 53)
            ],
            aiShortAnswer: "Выстоит",
            aiAnalysis: AIAnalysis(
                summary: "53% за «Выстоит»",
                pros: [
                "Снижение выбросов CO2 может стабилизировать течение",
                "Климатические модели показывают высокую неопределённость"
                ],
                cons: [
                "Скорость АМОК на историческом минимуме за 1600 лет",
                "Таяние льда Гренландии ускоряется быстрее прогнозов"
                ]
            )
        )
    ]

    // MARK: Flash Cards
    static let flashCards: [FlashCard] = [
        FlashCard(
            id: UUID(),
            question: "Will S&P 500 close green today?",
            category: "Finance",
            symbol: "chart.line.uptrend.xyaxis",
            imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
            aiShortAnswer: "Зелёный",
            aiAnalysis: AIAnalysis(
                summary: "61% за зелёное закрытие",
                pros: ["Фьючерсы на S&P растут с утра", "ФРС не будет повышать ставку"],
                cons: ["Геополитическая напряжённость давит на настроения", "Объём торгов ниже среднего"]
            )
        ),
        FlashCard(
            id: UUID(),
            question: "Will Arsenal win tonight?",
            category: "Sports",
            symbol: "sportscourt.fill",
            imageURL: "https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=800&q=80",
            aiShortAnswer: "Победа",
            aiAnalysis: AIAnalysis(
                summary: "58% за победу Арсенала",
                pros: ["Арсенал не проигрывает дома 11 матчей", "Соперник без ключевых игроков"],
                cons: ["Усталость после выездного тура", "Исторически проигрывают в кубковых играх"]
            )
        ),
        FlashCard(
            id: UUID(),
            question: "Will BTC touch $130k today?",
            category: "Crypto",
            symbol: "bitcoinsign.circle.fill",
            imageURL: "https://images.unsplash.com/photo-1518544866330-4e716499f800?w=800&q=80",
            aiShortAnswer: "Нет, рано",
            aiAnalysis: AIAnalysis(
                summary: "74% — BTC не достигнет $130k сегодня",
                pros: ["До цели остаётся >8% роста за один день", "Сильное сопротивление на $125k"],
                cons: ["Институциональный спрос стабильно растёт", "ETF-притоки за неделю превысили $2 млрд"]
            )
        ),
        FlashCard(
            id: UUID(),
            question: "Will Apple announce Vision Pro 2 this week?",
            category: "Tech",
            symbol: "desktopcomputer",
            imageURL: "https://images.unsplash.com/photo-1617802690992-15d93263d3a9?w=800&q=80",
            aiShortAnswer: "Не на неделе",
            aiAnalysis: AIAnalysis(
                summary: "82% — анонса на этой неделе не будет",
                pros: ["Apple не анонсировала мероприятие", "Производственный цикл ещё не завершён"],
                cons: ["Слухи от надёжных инсайдеров усилились", "Конкуренты уже выпустили аналоги"]
            )
        ),
        FlashCard(
            id: UUID(),
            question: "Will EUR/USD stay above 1.09 at close?",
            category: "Finance",
            symbol: "eurosign.circle.fill",
            imageURL: "https://images.unsplash.com/photo-1620321023374-d1a68fbc720d?w=800&q=80",
            aiShortAnswer: "Да, выше",
            aiAnalysis: AIAnalysis(
                summary: "66% — EUR/USD выше 1.09 на закрытии",
                pros: ["ЕЦБ сохраняет «ястребиную» риторику", "Слабый отчёт по занятости в США"],
                cons: ["Доллар укрепляется на фоне тарифных рисков", "Технически пара на ключевой поддержке"]
            )
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
}
