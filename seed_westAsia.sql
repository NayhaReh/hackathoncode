-- HOTSPOTS (West Asia)
INSERT INTO hotspots (country, label, risk_level, lat, lng) VALUES
('Turkey', 'Eastern Anatolia / Kurdish Communities', 'high', 39.0000, 41.0000),
('Iran', 'Kurdistan / Kurdish Tribes', 'high', 35.5000, 46.0000),
('Iraq', 'Iraqi Kurdistan / Yazidi Communities', 'high', 36.5000, 43.5000),
('Syria', 'Al-Hasakah / Assyrian Communities', 'high', 36.5000, 40.7500),
('Lebanon', 'Mount Lebanon / Aramaic-speaking Communities', 'medium', 34.0000, 35.9000),
('Palestine', 'Palestinian Villages / Minor Dialects', 'medium', 31.9000, 35.2000),
('Oman', 'Omani Mehri Tribe (Dhofar)', 'medium', 17.2000, 54.0000),
('Saudi Arabia', 'Najd / Janabiya & other Bedouin tribes', 'medium', 24.0000, 45.0000),
('Yemen', 'Socotra / Soqotri-speaking Communities', 'high', 12.5000, 53.9000);


-- CULTURES (West Asia)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note) VALUES

(1, 'Kurds (Turkey)', 'Indigenous ethnic group in Eastern Anatolia with rich oral tradition, music, and festivals.',
'Political pressures, forced assimilation, and limited use of Kurdish languages in schools.',
'language,oral-history,folk-music,ceremonies','high',
'Kurdish dialects in Turkey considered endangered; UNESCO lists many as vulnerable.'),

(2, 'Kurds (Iran)', 'Kurdish tribes in western Iran with strong cultural identity and traditional pastoralism.',
'Modernization, language suppression, and urban migration reduce traditional practices.',
'language,folk-music,oral-history,crafts','high',
'UNESCO and Ethnologue document endangered status for Kurdish dialects in Iran.'),

(3, 'Yazidi', 'Religious minority in northern Iraq with unique oral epics, ceremonies, and ancient practices.',
'Genocide, displacement, and diaspora reduce intergenerational cultural transmission.',
'language,ceremonies,oral-history,rituals','high',
'Yazidi language (Kurmanji variant) and traditions critically endangered.'),

(4, 'Assyrians', 'Christian Semitic minority in northeastern Syria with Aramaic language, churches, and festivals.',
'Conflict, migration, and low birth rates threaten survival of language and traditions.',
'language,ceremonies,religious-art,oral-history','high',
'Neo-Aramaic dialects spoken in Al-Hasakah listed as endangered by Ethnologue.'),

(5, 'Aramaic-speakers (Lebanon)', 'Small communities maintaining Western Aramaic dialects and oral traditions in Mount Lebanon.',
'Language shift to Arabic; few fluent speakers remain.',
'language,oral-history,folk-music,rituals','medium',
'UNESCO classifies Levantine Aramaic as severely endangered.'),

(6, 'Palestinians', 'Communities across Palestine with rich oral traditions, folklore, and minor local dialects.',
'Occupation, migration, and cultural disruption threaten preservation of local dialects and traditions.',
'language,oral-history,folk-music,ceremonies,crafts','medium',
'Some minor Palestinian dialects at risk; heritage preservation organizations document endangered practices.'),

(7, 'Mehri (Oman)', 'Indigenous tribe in Dhofar, speaking Mehri (South Arabian Semitic language) with oral poetry and maritime culture.',
'Language shift to Arabic among youth and urbanization threaten usage.',
'language,oral-poetry,rituals,folk-music','medium',
'Mehri language listed as endangered in Ethnologue.'),

(8, 'Bedouin Tribes (Saudi Arabia)', 'Nomadic tribes of central Najd maintaining oral traditions, music, and social rituals.',
'Modernization, settlement programs, and decline of nomadic lifestyle threaten practices.',
'language,oral-history,folk-music,rituals,crafts','medium',
'Some Bedouin dialects vulnerable; oral traditions at risk.'),

(9, 'Soqotri (Socotra, Yemen)', 'Semitic-speaking islanders with unique language, songs, and indigenous plant-based medicine.',
'Isolation and environmental change threaten language and traditional ecological knowledge.',
'language,oral-history,rituals,crafts,land-knowledge','high',
'Soqotri language classified as severely endangered by UNESCO.');


-- LANGUAGE PRESERVATION (sample phrases)
INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, ipa, audio_path, notes) VALUES
(1, 'Slav', 'Hello', 'slav', 'slɑv', NULL, 'Common Kurdish greeting.'),
(3, 'Êzî baş', 'Good morning', 'E-zee bash', 'eːzi bɑʃ', NULL, 'Yazidi morning greeting.'),
(4, 'Shlama amukh', 'Peace be upon you', 'shla-ma a-mukh', 'ʃlɑmɑ ɑmux', NULL, 'Neo-Aramaic greeting.'),
(7, 'Sbah al-khair', 'Good morning', 'sbah al-khair', 'sbɑh ɑl-xɑjr', NULL, 'Mehri greeting.'),
(9, 'Hala', 'Hello', 'ha-la', 'hɑlɑ', NULL, 'Soqotri greeting.');


-- TRADITIONS & ARTIFACTS
INSERT INTO traditions (culture_id, category, title, description, image_path) VALUES
(1, 'ceremony', 'Newroz', 'Kurdish New Year festival with dancing and traditional rituals.', NULL),
(3, 'ceremony', 'Jema', 'Yazidi religious gathering with prayers, dances, and rituals.', NULL),
(4, 'clothing', 'Traditional Assyrian Dress', 'Embroidered robes worn during festivals.', NULL),
(6, 'craft', 'Embroidery & Tile Patterns', 'Palestinian women produce traditional embroidery and ceramic patterns.', NULL),
(7, 'food', 'Fishermen Cuisine', 'Mehri traditional seafood dishes reflecting coastal lifestyle.', NULL),
(9, 'ceremony', 'Dragon Tree Rituals', 'Traditional Soqotri ecological ceremonies tied to endemic plants.', NULL);


-- STORIES (expanded for West Asia)
INSERT INTO stories (culture_id, title, story_text, contributor, status) VALUES

(1, 'Learning Kurdish Songs',
'Before we moved to the city, my grandmother would sit with me in the courtyard at sunset and teach me the old Kurdish songs she learned from her mother. She explained the meaning behind each verse — songs about love, exile, mountains, and resistance. Sometimes she would pause to tell me the story of where the song came from or who first sang it. Even now, when I hum those melodies in the busy streets of the city, I feel connected to our village, our language, and the generations who carried these songs before me. I keep practicing them so that one day I can pass them on to my own children.',
'Community member', 'approved'),

(3, 'Yazidi Epics',
'Each week, families in our community gather in a relative’s home to recite the sacred Yazidi epics. The elders lead the recitations slowly, ensuring every word is spoken correctly, while younger members listen and repeat the lines. Between verses, stories are shared about our history, our migrations, and the lessons contained within the epics. The gatherings are quiet but powerful, filled with a sense of continuity and reverence. For me, these evenings are a reminder that our culture lives not only in books but in voices, memory, and shared ritual.',
'Community member', 'approved'),

(6, 'Palestinian Folk Tales',
'In our village, evenings after the harvest are often spent gathered together while elders tell stories of our ancestors, the olive groves, and the traditions that shaped our lives. They speak about old farming methods, wedding celebrations, and the way the community once came together to help one another during difficult seasons. As children, we listen closely, sometimes asking questions about places and people we have never seen. These stories help us understand where we come from and why our traditions matter, reminding us that our identity is rooted in memory, land, and shared experience.',
'Community member', 'approved'),

(9, 'Soqotri Oral Poetry',
'Every evening on the island, our family sits outside as the air cools and the sky fills with stars. The elders chant Soqotri poems about the sea, the mountains, and the goats that sustain our livelihood. Each poem carries knowledge about weather, seasons, and the relationship between people and nature. As I repeat the verses, I learn not only the language but also how our ancestors understood the island’s rhythms. These nightly recitations feel like a living classroom, where poetry becomes both memory and guidance for the future.',
'Community member', 'approved');
