-- =========================
-- MySQL Schema for Heritage
-- =========================
USE heritage_db;

DROP TABLE IF EXISTS stories;
DROP TABLE IF EXISTS traditions;
DROP TABLE IF EXISTS language_phrases;
DROP TABLE IF EXISTS cultures;
DROP TABLE IF EXISTS hotspots;

CREATE TABLE hotspots (
  hotspot_id INT AUTO_INCREMENT PRIMARY KEY,
  country VARCHAR(100) NOT NULL,
  label VARCHAR(150) NOT NULL,
  risk_level ENUM('low','medium','high') NOT NULL,
  lat DOUBLE NOT NULL,
  lng DOUBLE NOT NULL
);

CREATE TABLE cultures (
  culture_id INT AUTO_INCREMENT PRIMARY KEY,
  hotspot_id INT NOT NULL,
  culture_name VARCHAR(150) NOT NULL,
  short_history TEXT NOT NULL,
  why_endangered TEXT NOT NULL,
  whats_at_risk TEXT NOT NULL,
  risk_level ENUM('low','medium','high') NOT NULL,
  sources_note TEXT,
  FOREIGN KEY (hotspot_id)
    REFERENCES hotspots(hotspot_id)
    ON DELETE CASCADE
);

CREATE TABLE language_phrases (
  phrase_id INT AUTO_INCREMENT PRIMARY KEY,
  culture_id INT NOT NULL,
  phrase_native VARCHAR(255) NOT NULL,
  phrase_english VARCHAR(255) NOT NULL,
  phonetic VARCHAR(255),
  ipa VARCHAR(255),
  audio_path VARCHAR(255),
  notes TEXT,
  FOREIGN KEY (culture_id)
    REFERENCES cultures(culture_id)
    ON DELETE CASCADE
);

CREATE TABLE traditions (
  tradition_id INT AUTO_INCREMENT PRIMARY KEY,
  culture_id INT NOT NULL,
  category ENUM('ceremony','clothing','craft','food') NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  image_path VARCHAR(255),
  FOREIGN KEY (culture_id)
    REFERENCES cultures(culture_id)
    ON DELETE CASCADE
);

CREATE TABLE stories (
  story_id INT AUTO_INCREMENT PRIMARY KEY,
  culture_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  story_text TEXT NOT NULL,
  contributor VARCHAR(150),
  status ENUM('pending','approved','rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (culture_id)
    REFERENCES cultures(culture_id)
    ON DELETE CASCADE
);

CREATE INDEX idx_hotspots_country ON hotspots(country);
CREATE INDEX idx_cultures_hotspot ON cultures(hotspot_id);
CREATE INDEX idx_phrases_culture ON language_phrases(culture_id);
CREATE INDEX idx_traditions_culture ON traditions(culture_id);
CREATE INDEX idx_stories_culture_status ON stories(culture_id, status);

ALTER TABLE hotspots
ADD UNIQUE KEY uniq_hotspot (country, label);

