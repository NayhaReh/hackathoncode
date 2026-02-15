-- HOTSPOTS (Africa)
INSERT INTO hotspots (country, label, risk_level, lat, lng) VALUES
('Nigeria', 'Niger Delta / Ogoni Communities', 'high', 5.0000, 6.0000),
('Ethiopia', 'Southern Nations / Hamar Tribe', 'high', 5.6000, 36.2500),
('Kenya', 'Northern Kenya / Rendille Tribe', 'medium', 2.8000, 38.5000),
('South Africa', 'Western Cape / Khoisan Communities', 'high', -33.0000, 21.5000),
('Cameroon', 'Adamawa / Tikar Communities', 'medium', 6.7000, 12.5000),
('Mali', 'Dogon Plateau', 'high', 14.4000, -3.5000),
('Morocco', 'High Atlas / Berber (Amazigh) Communities', 'medium', 31.0000, -7.5000),
('Mozambique', 'Niassa / Makonde Communities', 'medium', -12.5000, 36.0000),
('Tanzania', 'Ngorongoro Highlands / Maasai', 'medium', -3.5000, 35.8000);


-- CULTURES (Africa)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note) VALUES

(1, 'Ogoni', 'Indigenous Niger Delta people with rich cultural rituals, oral history, and environmental knowledge.',
'Oil pollution, displacement, and language loss threaten survival of traditions.',
'language,oral-history,rituals,land-knowledge,crafts','high',
'Ogoni language and customs endangered; documented by UNESCO and NGOs.'),

(2, 'Hamar', 'Ethiopian highland tribe known for bull-jumping ceremonies, body adornment, and oral storytelling.',
'Modernization and tourism impact traditional practices and intergenerational learning.',
'language,ceremonies,oral-history,rituals,clothing','high',
'Hamar language and rituals considered endangered by UNESCO.'),

(3, 'Rendille', 'Pastoralist communities in Northern Kenya maintaining camel herding, music, and oral tradition.',
'Climate change, urbanization, and assimilation threaten cultural continuity.',
'language,oral-history,herding-knowledge,rituals,folk-music','medium',
'Rendille language vulnerable; pastoral traditions at risk.'),

(4, 'Khoisan', 'Indigenous San peoples of Southern Africa with click languages, storytelling, and hunter-gatherer knowledge.',
'Language loss and land dispossession threaten survival.',
'language,oral-history,crafts,hunting-knowledge,rituals','high',
'Khoisan languages critically endangered; cultural practices threatened by modern expansion.'),

(5, 'Tikar', 'Cameroon highland community with art, mask-making, and festival traditions.',
'Urbanization and language shift threaten traditional ceremonies and crafts.',
'language,crafts,oral-history,ceremonies','medium',
'Tikar language and arts are documented as vulnerable by ethnologists.'),

(6, 'Dogon', 'People of the Dogon Plateau in Mali, known for cliffside villages, mask dances, and cosmology.',
'Climate pressures, migration, and lack of youth participation endanger traditions.',
'language,oral-history,ceremonies,folk-art,crafts','high',
'Dogon language and cultural rituals listed as endangered.'),

(7, 'Berber (Amazigh)', 'Indigenous North African communities in Morocco with unique language, music, and craft traditions.',
'Arabic dominance and urban migration reduce intergenerational language and cultural transmission.',
'language,oral-history,folk-music,crafts,rituals','medium',
'Berber languages classified as vulnerable by UNESCO.'),

(8, 'Makonde', 'Southeast Mozambique people known for wood carving, dance, and matrilineal traditions.',
'Urbanization and language shift threaten transmission of crafts and oral traditions.',
'language,crafts,oral-history,ceremonies','medium',
'Makonde language and crafts are vulnerable; UNESCO notes cultural risk.'),

(9, 'Maasai', 'Pastoralist communities of Tanzania with iconic clothing, beadwork, rituals, and cattle culture.',
'Land encroachment, modernization, and youth migration endanger traditions.',
'language,rituals,folk-art,clothing,herding-knowledge','medium',
'Maasai language and cultural practices at risk; documented by UNESCO and ethnologists.');


-- LANGUAGE PRESERVATION (sample phrases)
INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, ipa, audio_path, notes) VALUES
(1, 'Bue', 'Hello', 'bue', 'bwe', NULL, 'Ogoni greeting.'),
(2, 'Kaa', 'Good morning', 'kaa', 'kɑː', NULL, 'Hamar morning greeting.'),
(3, 'Wagyo', 'Hello', 'wa-gyo', 'waɡjo', NULL, 'Rendille greeting.'),
(4, '!Xóõ', 'Greetings', '!kho-o', 'ǃxóː', NULL, 'Khoisan greeting with click consonant.'),
(6, 'Sigi', 'Good day', 'si-gi', 'siɡi', NULL, 'Dogon greeting.'),
(7, 'Azul', 'Hello', 'a-zul', 'ɑzul', NULL, 'Berber (Amazigh) greeting.'),
(9, 'Supai', 'Hello', 'su-pai', 'supɑɪ', NULL, 'Maasai greeting.');


-- TRADITIONS & ARTIFACTS
INSERT INTO traditions (culture_id, category, title, description, image_path) VALUES
(2, 'ceremony', 'Bull-jumping', 'Hamar rite of passage for young men with ritual dances and body adornment.', NULL),
(4, 'craft', 'Beadwork & Hunting Tools', 'Khoisan traditional beadwork and hunting tools passed through generations.', NULL),
(5, 'craft', 'Tikar Mask-making', 'Wooden masks used in festivals and initiation ceremonies.', NULL),
(6, 'ceremony', 'Dogon Mask Dance', 'Traditional dances connected to cosmology and ancestor worship.', NULL),
(7, 'craft', 'Berber Weaving', 'Traditional textiles and carpets crafted by Amazigh women.', NULL),
(8, 'craft', 'Makonde Wood Carving', 'Intricate carvings representing spirits, daily life, and ceremonies.', NULL),
(9, 'ceremony', 'Maasai Eunoto', 'Coming-of-age ceremony for young Maasai men with rituals and communal gatherings.', NULL);


-- STORIES (expanded)
INSERT INTO stories (culture_id, title, story_text, contributor, status) VALUES

(1, 'Ogoni River Stories', 
'Elders gather us by the riverside at sunset, where the water glistens like molten gold. They tell stories of the river spirits and the forests that once covered our lands, teaching us how to fish, plant, and move respectfully with nature. Every tale carries lessons about courage, unity, and care for the earth. Through these stories, we learn the history of our people, how our ancestors defended the land, and how every river bend and forest clearing has a meaning. It is here that I first felt the connection between my actions and the life around me.', 
'Community member', 'approved'),

(2, 'Hamar Festival', 
'During the annual bull-jumping ceremony, our village transforms into a whirlwind of color, music, and movement. The elders explain every ritual step as young men prepare for adulthood. We sing songs that narrate the deeds of our forefathers, drum rhythms echo across the valley, and the women braid their hair with bright beads and cowrie shells. I remember holding my younger brother’s hand as we watched the ceremony, learning the importance of bravery, respect, and community bonds. These moments make me proud of our Hamar heritage and remind me that our traditions must be passed down carefully.', 
'Community member', 'approved'),

(4, 'Khoisan Hunting Tales', 
'From early morning, I would walk with my grandfather through the bush, listening to the soft whispers of the wind. He taught me how to track animals, read the patterns of the stars, and identify the medicinal plants hidden in the scrub. Every evening, we would sit around the fire and he would tell stories of the hunters who came before us, the spirits of the land, and the lessons they left behind. These stories were not just entertainment—they were instructions for life, teaching respect for every living being and the balance of nature. Through his stories, I learned patience, skill, and humility.', 
'Community member', 'approved'),

(6, 'Dogon Legends', 
'In the shadow of the cliffs, we gather as the sun dips behind the plateau. Our elders begin reciting the legends of our people: how the first ancestors shaped the land, how the stars guide our harvest, and how every village owes its spirit to the gods of the plateau. The tales are full of caution, wisdom, and humor, and each child is expected to remember at least one story each season. I remember the thrill of listening to these epics, the way the drums and flutes accentuated the drama, and how the stories connected us to our past and to each other. These legends are our compass for living in harmony with our land.', 
'Community member', 'approved'),

(9, 'Maasai Cattle Stories', 
'Every morning before the sun rises, our elders lead us to the pastures with the cattle, teaching us stories about each clan’s history and the journeys of our ancestors. They tell of great warriors, clever herders, and the spirits that protect our livestock. As we guide the cattle across rivers and plains, the lessons come alive: how to care for animals, respect the environment, and support our community. Each tale is paired with practical advice, and I still recall the excitement of my first storytelling session, feeling the rhythm of the drums and the echo of the elders’ voices against the hills. These stories ensure that our Maasai traditions endure with every generation.', 
'Community member', 'approved');
