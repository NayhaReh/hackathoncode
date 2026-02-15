USE heritage_db;

-- ==========================================
-- CANADA (ALL-IN-ONE SEED)
-- Hotspots + Cultures + Phrases + Traditions + Stories
-- ==========================================

-- ----------------------
-- HOTSPOTS (Canada)
-- Uses ON DUPLICATE KEY UPDATE because uniq_hotspot(country,label) exists
-- ----------------------
INSERT INTO hotspots (country, label, risk_level, lat, lng)
VALUES
('Canada', 'Haida Gwaii (BC)', 'high', 53.2520, -132.0870),
('Canada', 'Bella Coola / Nuxalk Territory (BC)', 'high', 52.3730, -126.7520),
('Canada', 'Siksiká / Blackfoot (AB)', 'medium', 50.6400, -113.4400),
('Canada', 'Treaty 6/8 Cree Regions (AB/SK)', 'medium', 53.5440, -113.4900),
('Canada', 'Innu Communities (QC/Labrador)', 'medium', 50.2140, -66.3840),
('Canada', 'Kahnawà:ke / Mohawk (QC)', 'medium', 45.3900, -73.7000),
('Canada', 'Métis Michif Communities (MB)', 'high', 49.9000, -97.1400),
('Canada', 'Heiltsuk / Bella Bella (BC)', 'high', 52.1670, -128.1450)
ON DUPLICATE KEY UPDATE
  risk_level = VALUES(risk_level),
  lat = VALUES(lat),
  lng = VALUES(lng);

-- ----------------------
-- CULTURES (Canada)
-- hotspot_id is looked up by (country,label) so foreign keys never fail
-- ----------------------

-- Haida
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Haida',
       'Indigenous nation of the Northwest Coast with deep ties to Haida Gwaii and a strong tradition of oral history, art, and governance.',
       'Language shift and historical assimilation pressures reduced fluent speakers; revitalization efforts continue through community teaching and cultural programming.',
       'language,oral-history,carving,weaving,place-names,clan-stories',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Haida Gwaii (BC)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Nuxalk
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Nuxalk',
       'Indigenous people of the Central Coast (Bella Coola area) with cultural knowledge rooted in land stewardship, community responsibility, and oral tradition.',
       'Very small number of fluent speakers and limited intergenerational transmission; learning programs work to rebuild everyday language use.',
       'language,ceremonies,oral-history,land-knowledge,place-names,community-teaching',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Bella Coola / Nuxalk Territory (BC)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Blackfoot (Siksiká / Niitsitapi)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Blackfoot (Niitsitapi)',
       'Plains Indigenous nation with rich ceremonial life, language, and artistic traditions tied to family networks and seasonal cycles.',
       'Historic suppression of language and cultural practices reduced transmission; many communities now rebuild fluency through classes and cultural camps.',
       'language,ceremonies,beadwork,clothing,oral-teaching,songs',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Siksiká / Blackfoot (AB)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Cree (Treaty 6/8 regions)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Cree (selected communities/dialects)',
       'One of the largest Indigenous groups across Canada; dialects and traditions vary by region, with strong identity tied to land, kinship, and oral history.',
       'Language transmission is uneven across communities; some dialect areas face declining mother-tongue use while others continue strong revitalization.',
       'language-dialects,oral-history,seasonal-practices,land-knowledge,community-stories',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Treaty 6/8 Cree Regions (AB/SK)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Innu
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Innu (Innu-aimun)',
       'Innu communities across parts of Quebec and Labrador with land-based knowledge, travel routes, and oral tradition shaped by the seasons.',
       'Pressure from dominant languages and changes in schooling/media reduce everyday use for some youth; transmission varies by community.',
       'language,land-knowledge,oral-history,traditions,place-names,stories',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Innu Communities (QC/Labrador)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Mohawk (Kahnawà:ke)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Mohawk (Kanien’kéha)',
       'Haudenosaunee nation with strong governance, ceremony, and cultural identity expressed through language, community life, and intergenerational teaching.',
       'Language shift pressures mean revitalization often relies on immersion, community programs, and dedicated speakers mentoring learners.',
       'language,ceremonies,oral-history,identity-knowledge,community-teaching',
       'medium',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Kahnawà:ke / Mohawk (QC)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Métis (Michif)
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Métis (Michif)',
       'Métis communities with distinct identity and mixed-language heritage, including Michif varieties tied to family stories and community history.',
       'Very low first-language use and limited number of fluent speakers; many learners reconnect through community classes and cultural gatherings.',
       'language,identity-stories,oral-history,community-memory',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Métis Michif Communities (MB)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- Heiltsuk
INSERT INTO cultures (hotspot_id, culture_name, short_history, why_endangered, whats_at_risk, risk_level, sources_note)
SELECT h.hotspot_id,
       'Heiltsuk (Híɫzaqv)',
       'Coastal nation with language and traditions closely tied to place, community relationships, and knowledge passed through families and elders.',
       'Small number of fluent speakers in many settings; revitalization efforts focus on teaching, documentation, and community language use.',
       'language,oral-history,land-knowledge,ceremonies,place-names',
       'high',
       'Seeded for demo; replace/verify with curated sources and community guidance.'
FROM hotspots h
WHERE h.country='Canada' AND h.label='Heiltsuk / Bella Bella (BC)'
ON DUPLICATE KEY UPDATE
  short_history=VALUES(short_history),
  why_endangered=VALUES(why_endangered),
  whats_at_risk=VALUES(whats_at_risk),
  risk_level=VALUES(risk_level),
  sources_note=VALUES(sources_note);

-- ----------------------
-- LANGUAGE PHRASES (Canada)
-- Looks up culture_id by culture_name (safe even if IDs change)
-- ----------------------
INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Háw''aa', 'Thank you', 'HAH-wah', 'Used to show gratitude'
FROM cultures c WHERE c.culture_name='Haida';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Sk''áang', 'Friend', 'SKAH-ang', 'Friendly term used in greetings'
FROM cultures c WHERE c.culture_name='Haida';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Núyem', 'Hello', 'NOO-yem', 'Traditional greeting'
FROM cultures c WHERE c.culture_name='Nuxalk';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Oki', 'Hello', 'OH-kee', 'Common greeting'
FROM cultures c WHERE c.culture_name='Blackfoot (Niitsitapi)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Tânisi', 'Hello', 'TAH-nee-see', 'Common Cree greeting'
FROM cultures c WHERE c.culture_name='Cree (selected communities/dialects)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Kuei', 'Hello', 'KWAY', 'Innu greeting (regional variation exists)'
FROM cultures c WHERE c.culture_name='Innu (Innu-aimun)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Skennen’kó:wa', 'Peace', 'SKEH-nen-go-wa', 'Often used when speaking about harmony/peace'
FROM cultures c WHERE c.culture_name='Mohawk (Kanien’kéha)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Tawnshi', 'Hello', 'TOWN-shee', 'Common Michif greeting'
FROM cultures c WHERE c.culture_name='Métis (Michif)';

INSERT INTO language_phrases (culture_id, phrase_native, phrase_english, phonetic, notes)
SELECT c.culture_id, 'Gilakas’la', 'Thank you', 'gee-LAH-kahs-la', 'Common thank you'
FROM cultures c WHERE c.culture_name='Heiltsuk (Híɫzaqv)';

-- ----------------------
-- TRADITIONS (Canada)
-- ----------------------
INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Haida Totem & Crest Carving',
       'Cedar carving used to represent lineage, clan crests, and historical stories; knowledge is taught through mentorship and practice.'
FROM cultures c WHERE c.culture_name='Haida';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'ceremony', 'Potlatch (Northwest Coast)',
       'A community gathering that can mark major life events and responsibilities; it reinforces relationships, sharing, and cultural continuity.'
FROM cultures c WHERE c.culture_name='Haida';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Blackfoot Beadwork',
       'Detailed bead designs used in clothing and regalia; patterns and technique are often passed through families.'
FROM cultures c WHERE c.culture_name='Blackfoot (Niitsitapi)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'ceremony', 'Seasonal Ceremonies',
       'Seasonal practices and gatherings that honour land, relationships, and responsibilities, shaped by local Cree community traditions.'
FROM cultures c WHERE c.culture_name='Cree (selected communities/dialects)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'food', 'Michif Bannock',
       'Bread often made for family gatherings and community events; recipes and methods vary by family and region.'
FROM cultures c WHERE c.culture_name='Métis (Michif)';

INSERT INTO traditions (culture_id, category, title, description)
SELECT c.culture_id, 'craft', 'Coastal Weaving & Basketry',
       'Weaving using local plant fibers; items may be used for daily life, gifting, and ceremonial contexts.'
FROM cultures c WHERE c.culture_name='Heiltsuk (Híɫzaqv)';

-- ----------------------
-- STORIES (Canada) - detailed + believable
-- ----------------------
INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Learning to Carve with My Grandfather',
       'My grandfather never started a lesson with tools. He started with a walk. We would go out when the tide was low, or into the forest when the rain was light, and he would point at cedar and talk about what it meant to take from the land with respect.\n\nWhen we finally carved, he explained that a figure isn’t “just” an animal. It’s a relationship—between our family, our history, and the place we come from. He would stop me when I rushed, not to criticize, but to remind me to listen. “If your hands are impatient,” he said, “your work will be impatient too.”\n\nYears later, I realized he wasn’t only teaching carving. He was teaching how to hold stories. Now, when younger relatives ask to learn, I try to begin the same way: not with a perfect result, but with respect, patience, and the reminder that what we make carries memory.',
       'Haida community member',
       'approved'
FROM cultures c WHERE c.culture_name='Haida';

INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Speaking Cree at Home',
       'When I was little, English followed me everywhere—school, television, even the signs on the street. My parents decided that inside our home, Cree would be the language of daily life. At first I resisted. I didn’t want to sound “different” when friends came over.\n\nMy grandmother stayed calm. She would repeat phrases as she cooked, as she folded laundry, as she braided my hair. I learned without noticing—through routine, humour, and stories told at the table. One winter, when the power went out, she told stories by candlelight and I realized something: Cree held a kind of warmth I couldn’t translate.\n\nNow, I use Cree with my own children in the same ordinary ways—wake-up greetings, quick reminders, little jokes. Revitalization can look like big programs, but it also looks like a family choosing to speak, every day, even when it’s easier not to.',
       'Cree elder',
       'approved'
FROM cultures c WHERE c.culture_name='Cree (selected communities/dialects)';

INSERT INTO stories (culture_id, title, story_text, contributor, status)
SELECT c.culture_id,
       'Keeping Michif Alive',
       'Growing up, I heard Michif mostly in fragments—an expression here, a teasing phrase there, usually from older relatives who switched back to English when they noticed kids listening. It wasn’t that they didn’t want us to learn. It was that they had learned to protect the language by keeping it private.\n\nA few years ago, our community started weekly language nights. The first sessions were awkward. People were shy, and nobody wanted to “mess up.” Then an elder laughed and said, “If you’re not making mistakes, you’re not learning.” That changed everything.\n\nNow those nights are one of the most consistent intergenerational spaces we have. We practice greetings, we learn old songs, we hear stories about relatives and places that don’t always show up in textbooks. For me, Michif is not only vocabulary—it’s belonging. Every new learner feels like a small victory against forgetting.',
       'Métis youth',
       'approved'
FROM cultures c WHERE c.culture_name='Métis (Michif)';
