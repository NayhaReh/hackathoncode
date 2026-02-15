USE heritage_db;

-- ==========================================
-- AMERICAS (ALL-IN-ONE SEED)
-- Hotspots + Cultures + Phrases + Traditions + Stories
-- ==========================================

-- ----------------------
-- HOTSPOTS (USA + South America)
-- Uses ON DUPLICATE KEY UPDATE because you have uniq_hotspot(country,label)
-- ----------------------
INSERT INTO hotspots (country, label, risk_level, lat, lng)
VALUES
('United States', 'Navajo Nation (AZ/NM/UT)', 'medium', 36.1225, -109.4867),
('United States', 'Lakota Territories (SD)', 'medium', 44.3683, -100.3509),
('United States', 'Cherokee Nation (OK)', 'medium', 35.5520, -94.8780),
('Brazil', 'Yanomami Territory (Amazon)', 'high', 2.8167, -62.0167),
('Peru', 'Andean Quechua Regions', 'medium', -13.1631, -72.5450),
('Peru', 'Shipibo Communities (Amazon Basin)', 'high', -7.0000, -74.0000)
ON DUPLICATE KEY UPDATE
  risk_level = VALUES(risk_level),
  lat = VALUES(lat),
  lng = VALUES(lng);

-- ----------------------
-- CULTURES (USA + South America)
-- Uses hotspot lookup by (country,label) so foreign keys never fail
-- ----------------------

-- USA: Navajo
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Navajo (Diné)',
       'Indigenous nation of the American Southwest with strong spiritual ties to land, oral tradition, and community ceremony.',
       'Language shift to English and reduced youth fluency despite revitalization efforts in schools and communities.',
       'language,ceremonies,weaving,oral-history,land-knowledge,place-names',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='United States' AND h.label='Navajo Nation (AZ/NM/UT)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- USA: Lakota
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Lakota (Sioux)',
       'Great Plains Indigenous people with strong kinship networks, ceremonial life, and oral histories tied to land and seasonal cycles.',
       'Historic displacement and schooling policies disrupted intergenerational language transmission; many learners now rebuild fluency through community programs.',
       'language,ceremonies,oral-history,cultural-teaching,songs,community-gatherings',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='United States' AND h.label='Lakota Territories (SD)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- USA: Cherokee
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Cherokee',
       'Southeastern Indigenous nation with a written syllabary and long-standing traditions of storytelling, governance, and craft.',
       'Aging speaker population and limited fluent youth speakers in many communities; revitalization continues through immersion education and cultural programs.',
       'language,storytelling,ceremonies,traditional-knowledge,crafts,identity',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='United States' AND h.label='Cherokee Nation (OK)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Brazil: Yanomami
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Yanomami',
       'Amazon rainforest Indigenous people living in communal villages whose culture is deeply connected to forest ecology, hunting knowledge, and oral tradition.',
       'Deforestation, illegal mining, disease, and land invasion threaten community safety and the ability to maintain traditional ways of life.',
       'language,forest-knowledge,healing-practices,oral-history,community-life,land-rights',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Brazil' AND h.label='Yanomami Territory (Amazon)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Peru: Quechua
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Quechua Communities',
       'Andean communities with cultural roots connected to the Inca period and later highland traditions, including weaving, farming knowledge, and oral storytelling.',
       'Spanish dominance in education and urban migration pressures reduce everyday use for some families, especially in cities.',
       'language,weaving,festivals,agricultural-knowledge,place-names,oral-history',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Peru' AND h.label='Andean Quechua Regions'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Peru: Shipibo-Conibo
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Shipibo-Conibo',
       'Amazonian Indigenous people known for intricate textile patterns and spiritual traditions tied to rivers, forests, and community ceremony.',
       'Deforestation and modernization pressures can reduce access to traditional lands and materials needed for cultural practices.',
       'language,crafts,ceremonies,plant-knowledge,oral-history,land-rights',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Peru' AND h.label='Shipibo Communities (Amazon Basin)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- ----------------------
-- LANGUAGE PHRASES (USA + South America)
-- Culture lookup by name (IDs can change, this stays safe)
-- ----------------------

-- USA
INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Yáʼátʼééh', 'Hello', 'YAH-ah-teh', 'Common greeting; often used when meeting someone'
FROM cultures c WHERE c.culture_name='Navajo (Diné)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Hau', 'Hello', 'HOW', 'Often introduced as a basic greeting in Lakota context'
FROM cultures c WHERE c.culture_name='Lakota (Sioux)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Osiyo', 'Hello', 'oh-SEE-yo', 'Common greeting; used in community and cultural events'
FROM cultures c WHERE c.culture_name='Cherokee';

-- South America (keep these as placeholders unless you have verified phrases)
INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, '—', 'Hello', NULL, 'Placeholder: replace with community-verified phrase + audio'
FROM cultures c WHERE c.culture_name='Yanomami';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Rimaykullayki', 'Greetings', 'ree-my-koo-LIE-kee', 'Common Quechua greeting (varies by region)'
FROM cultures c WHERE c.culture_name='Quechua Communities';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, '—', 'Thank you', NULL, 'Placeholder: replace with community-verified phrase + audio'
FROM cultures c WHERE c.culture_name='Shipibo-Conibo';

-- ----------------------
-- TRADITIONS (USA + South America)
-- ----------------------
INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'ceremony', 'Blessing Way (Hózhǫ́ǫ́jí)', 'A healing tradition focused on restoring balance and harmony through prayer, song, and community support.'
FROM cultures c WHERE c.culture_name='Navajo (Diné)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Weaving & Textile Art', 'Textile traditions often carry family meaning and place-based identity through pattern, technique, and teaching.'
FROM cultures c WHERE c.culture_name='Navajo (Diné)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'ceremony', 'Sun Dance', 'A sacred renewal ceremony centered on prayer, endurance, and community responsibility.'
FROM cultures c WHERE c.culture_name='Lakota (Sioux)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Cherokee Basket Weaving', 'Handwoven baskets made from natural materials, with techniques taught across generations.'
FROM cultures c WHERE c.culture_name='Cherokee';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Shipibo Pattern (Kené)', 'Intricate pattern traditions applied to textiles and objects, often learned through community teaching and practice.'
FROM cultures c WHERE c.culture_name='Shipibo-Conibo';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'food', 'Highland Farming Foods', 'Cuisine shaped by highland crops and seasonal cycles; meals often connect families and festivals.'
FROM cultures c WHERE c.culture_name='Quechua Communities';

-- ----------------------
-- STORIES (detailed + believable)
-- ----------------------

-- Navajo
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Walking in Beauty, One Day at a Time',
       'My grandmother used to start the morning before the house was fully awake. She would open the door, stand quietly, and say a few words to greet the day. When I asked why, she told me it was a way of keeping myself steady—remembering that the world is bigger than my worries.\n\nAs I got older, school and work pulled me into English more and more, and I noticed I could understand our language faster than I could speak it. I started feeling embarrassed when I couldn’t answer quickly. My grandmother never shamed me. She would repeat the phrase slowly, like she was laying down a path I could follow.\n\nA few years ago, I began recording her voice (only when she felt comfortable). Just short clips—greetings, place names, and the little reminders she gave when someone was stressed. Now, when my younger cousins ask how to say something, I don’t just type it. I play a clip of her saying it, and we practice together. It’s not perfect, but it feels real. It feels like a thread between us: imperfect, but still unbroken.',
       'Navajo community member',
       'approved'
FROM cultures c WHERE c.culture_name='Navajo (Diné)';

-- Lakota
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'The Drum at the Center',
       'When I was a kid, I thought the drum was just music. Then I sat close enough to feel it in my chest. My uncle told me to listen like it was a heartbeat—steady, living, and shared.\n\nAt gatherings, the older men would correct my timing gently, and the women would laugh when I rushed because I was excited. Years later, after a funeral, I understood why people say the drum holds us together. When words were hard, that rhythm carried the room.\n\nIt’s also why teaching the songs matters: the language lives inside them. Even when someone is shy to speak, they’ll sing. That’s how some of our young people come back to it—one verse at a time. When a teenager learns a song and asks what a line means, that’s not just curiosity. That’s the culture pulling them home.',
       'Lakota elder',
       'approved'
FROM cultures c WHERE c.culture_name='Lakota (Sioux)';

-- Cherokee
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Our Language, Our Strength',
       'My great-aunt still remembers being told to stop speaking Cherokee when she was little. She said it wasn’t just the words that disappeared—it was the jokes, the nicknames, the way people teased each other lovingly. When our community started language classes, she volunteered even though she was nervous.\n\nShe would sit at the front with a notebook and whisper the words to herself before saying them out loud. One day a kid in the class asked her how to pronounce a phrase, and she smiled like she had been waiting years for someone to ask.\n\nNow, when we host family dinners, we pick one “language moment” for the night—greetings, introductions, or a short story. It’s small, but it changes the feeling in the room. It reminds us we’re not just preserving a word list. We’re bringing back a way of being together.',
       'Cherokee teacher',
       'approved'
FROM cultures c WHERE c.culture_name='Cherokee';

-- Quechua
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Threads That Remember',
       'My mother taught me to weave when I was old enough to sit still and listen. She didn’t start with big patterns. First, she taught me to feel the tension in the thread and to notice when my hands were rushing. Later she showed me how certain designs are connected to where we live—mountains, rivers, and the plants that grow near our fields.\n\nWhen I moved to the city for school, I stopped weaving for a while. I told myself I was too busy, but really I was afraid people would treat it like a costume or a souvenir. The first time I visited home again, my aunt put a half-finished piece in my hands and said, “Finish it, so it doesn’t forget you.”\n\nNow I weave again, even if it’s only a little each week. I teach my younger cousins the names of colors and shapes in our language while we work. It’s not just craft—it’s memory you can hold.',
       'Quechua community member',
       'approved'
FROM cultures c WHERE c.culture_name='Quechua Communities';

-- Shipibo-Conibo
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Patterns on the River',
       'When I was young, I thought the patterns on our cloth were just decoration. My grandmother told me to look closer. She said the lines carry knowledge—how we see the world, how we remember the river, how we keep balance when life changes.\n\nSome families now buy factory fabrics because they’re cheaper and faster. I understand why. But when we stop making our own patterns, we lose more than a design. We lose a way of learning. Sitting together, preparing materials, and sharing stories is where children absorb who they are.\n\nI started teaching pattern-making to girls in my neighborhood on weekends. We don’t call it a class; we call it time together. Sometimes we talk about the forest and what is changing. Sometimes we just laugh. But every time someone finishes a piece, they stand a little taller. It reminds me that preservation isn’t only museums—it’s living practice.',
       'Shipibo community member',
       'approved'
FROM cultures c WHERE c.culture_name='Shipibo-Conibo';

-- Yanomami (keep story general and respectful for demo)
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Forest Knowledge',
       'An elder once explained to me that the forest is not a backdrop—it is the library. Medicines, food, and teaching are all there, and learning happens by walking, watching, and listening. When outsiders damage the forest, it affects much more than trees. It interrupts how knowledge is passed down.\n\nIn conversations, people often ask for “facts,” but what I remember most is how the community speaks about responsibility: taking only what is needed, sharing resources, and respecting the places that sustain life. Preserving culture here means protecting the conditions that allow daily life and teaching to continue.',
       'Community member (demo)',
       'approved'
FROM cultures c WHERE c.culture_name='Yanomami';
