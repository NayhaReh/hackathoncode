# static/components/data.py
import json
import re
from pathlib import Path
from urllib.request import urlopen

NO_DATA_COLOR = "#d9d9d9"
ISO_FIELD = "ISO3166-1-Alpha-3"
GEOJSON_URL = "https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson"
PROJECT_ROOT = Path(__file__).resolve().parents[2]

SEED_FILES = [
    "seed_america.sql",
    "seed_Africa.sql",
    "seed_EastAsia.sql",
    "seed_MiddleAsia.sql",
    "seed_westAsia.sql",
    "seed_canada.sql",
]

RISK_WEIGHT = {"low": 1, "medium": 2, "high": 3}
RISK_SCORE = {"low": 0.3, "medium": 0.6, "high": 0.9}
COUNTRY_ALIASES = {
    "united states of america": "united states",
    "usa": "united states",
    "russian federation": "russia",
    "cote divoire": "ivory coast",
    "korea, republic of": "south korea",
    "korea, democratic peoples republic of": "north korea",
    "syrian arab republic": "syria",
    "iran, islamic republic of": "iran",
}

HOTSPOT_RE = re.compile(
    r"\('([^']+)',\s*'([^']+)',\s*'(low|medium|high)',\s*(-?\d+(?:\.\d+)?),\s*(-?\d+(?:\.\d+)?)\)",
    re.IGNORECASE,
)
SELECT_CULTURE_RE = re.compile(
    r"INSERT INTO cultures .*?SELECT h\.hotspot_id,\s*'(?P<culture>(?:''|[^'])*)'.*?WHERE h\.country='(?P<country>(?:''|[^'])*)' "
    r"AND h\.label='(?P<label>(?:''|[^'])*)'.*?;",
    re.IGNORECASE | re.DOTALL,
)
VALUES_CULTURE_RE = re.compile(
    r"\(\s*(\d+)\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'(low|medium|high)'",
    re.IGNORECASE,
)
SELECT_PHRASE_RE = re.compile(
    r"INSERT INTO language_phrases .*?SELECT c\.culture_id,\s*'(?P<native>(?:''|[^'])*)'\s*,\s*'(?P<english>(?:''|[^'])*)'.*?"
    r"WHERE c\.culture_name='(?P<culture>(?:''|[^'])*)'",
    re.IGNORECASE | re.DOTALL,
)
VALUES_PHRASE_RE = re.compile(
    r"\(\s*(\d+)\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'",
    re.IGNORECASE,
)
SELECT_TRADITION_RE = re.compile(
    r"INSERT INTO traditions .*?SELECT c\.culture_id,\s*'(?P<category>(?:''|[^'])*)'\s*,\s*'(?P<title>(?:''|[^'])*)'\s*,\s*'(?P<description>(?:''|[^'])*)'"
    r".*?WHERE c\.culture_name='(?P<culture>(?:''|[^'])*)'",
    re.IGNORECASE | re.DOTALL,
)
VALUES_TRADITION_RE = re.compile(
    r"\(\s*(\d+)\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'",
    re.IGNORECASE,
)
SELECT_STORY_RE = re.compile(
    r"INSERT INTO stories .*?SELECT c\.culture_id,\s*'(?P<title>(?:''|[^'])*)'\s*,\s*'(?P<story>(?:''|[^'])*)'\s*,\s*'(?P<contributor>(?:''|[^'])*)'"
    r".*?WHERE c\.culture_name='(?P<culture>(?:''|[^'])*)'",
    re.IGNORECASE | re.DOTALL,
)
VALUES_STORY_RE = re.compile(
    r"\(\s*(\d+)\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'\s*,\s*'((?:''|[^'])*)'",
    re.IGNORECASE | re.DOTALL,
)


def _sql_unescape(value):
    return (value or "").replace("''", "'").strip()


def _normalize_country_name(value):
    normalized = re.sub(r"[^a-z0-9 ]+", "", (value or "").strip().lower())
    normalized = re.sub(r"\s+", " ", normalized).strip()
    return COUNTRY_ALIASES.get(normalized, normalized)


def _iter_seed_texts():
    for seed_file in SEED_FILES:
        path = PROJECT_ROOT / seed_file
        if path.exists():
            yield seed_file, path.read_text(encoding="utf-8", errors="ignore")


def _status_from_risk_list(levels):
    if not levels:
        return "Low"
    highest = max(levels, key=lambda level: RISK_WEIGHT.get(level, 0))
    return highest.title()


def _new_record(country_name):
    return {
        "country": country_name,
        "hotspots": [],
        "cultures": [],
        "risk_levels": [],
        "phrases": [],
        "traditions": [],
        "stories": [],
    }


def _dedupe_dict_list(items, key_fields):
    seen = set()
    output = []
    for item in items:
        key = tuple(item.get(field) for field in key_fields)
        if key in seen:
            continue
        seen.add(key)
        output.append(item)
    return output


def _build_country_records_from_sql():
    records = {}

    for _file_name, text in _iter_seed_texts():
        hotspots = []
        local_cultures = []
        culture_to_country = {}

        for country, label, risk, lat, lng in HOTSPOT_RE.findall(text):
            country = _sql_unescape(country)
            label = _sql_unescape(label)
            norm_country = _normalize_country_name(country)
            hotspot = {
                "country": country,
                "label": label,
                "risk_level": risk.lower(),
                "lat": float(lat),
                "lng": float(lng),
            }
            hotspots.append(hotspot)
            record = records.setdefault(norm_country, _new_record(country))
            record["hotspots"].append(hotspot)
            record["risk_levels"].append(hotspot["risk_level"])

        indexed_hotspots = {index + 1: item for index, item in enumerate(hotspots)}

        for hotspot_id, culture_name, _history, _why, _risk_text, risk in VALUES_CULTURE_RE.findall(text):
            hotspot = indexed_hotspots.get(int(hotspot_id))
            if not hotspot:
                continue
            country = hotspot["country"]
            culture_name = _sql_unescape(culture_name)
            norm_country = _normalize_country_name(country)
            record = records.setdefault(norm_country, _new_record(country))
            record["cultures"].append(culture_name)
            record["risk_levels"].append(risk.lower())
            culture_to_country[culture_name] = norm_country
            local_cultures.append({"country": norm_country, "culture": culture_name})

        for match in SELECT_CULTURE_RE.finditer(text):
            country = _sql_unescape(match.group("country"))
            culture = _sql_unescape(match.group("culture"))
            norm_country = _normalize_country_name(country)
            record = records.setdefault(norm_country, _new_record(country))
            record["cultures"].append(culture)
            culture_to_country[culture] = norm_country
            local_cultures.append({"country": norm_country, "culture": culture})

        local_culture_by_id = {
            index + 1: entry for index, entry in enumerate(local_cultures)
        }

        for match in SELECT_PHRASE_RE.finditer(text):
            culture = _sql_unescape(match.group("culture"))
            norm_country = culture_to_country.get(culture)
            if not norm_country:
                continue
            records[norm_country]["phrases"].append(
                {
                    "native": _sql_unescape(match.group("native")),
                    "english": _sql_unescape(match.group("english")),
                    "culture": culture,
                }
            )

        for culture_id, native, english in VALUES_PHRASE_RE.findall(text):
            culture_entry = local_culture_by_id.get(int(culture_id))
            if not culture_entry:
                continue
            records[culture_entry["country"]]["phrases"].append(
                {
                    "native": _sql_unescape(native),
                    "english": _sql_unescape(english),
                    "culture": culture_entry["culture"],
                }
            )

        for match in SELECT_TRADITION_RE.finditer(text):
            culture = _sql_unescape(match.group("culture"))
            norm_country = culture_to_country.get(culture)
            if not norm_country:
                continue
            records[norm_country]["traditions"].append(
                {
                    "category": _sql_unescape(match.group("category")),
                    "title": _sql_unescape(match.group("title")),
                    "description": _sql_unescape(match.group("description")),
                    "culture": culture,
                }
            )

        for culture_id, category, title, description in VALUES_TRADITION_RE.findall(text):
            culture_entry = local_culture_by_id.get(int(culture_id))
            if not culture_entry:
                continue
            records[culture_entry["country"]]["traditions"].append(
                {
                    "category": _sql_unescape(category),
                    "title": _sql_unescape(title),
                    "description": _sql_unescape(description),
                    "culture": culture_entry["culture"],
                }
            )

        for match in SELECT_STORY_RE.finditer(text):
            culture = _sql_unescape(match.group("culture"))
            norm_country = culture_to_country.get(culture)
            if not norm_country:
                continue
            records[norm_country]["stories"].append(
                {
                    "title": _sql_unescape(match.group("title")),
                    "text": _sql_unescape(match.group("story")),
                    "contributor": _sql_unescape(match.group("contributor")),
                    "culture": culture,
                }
            )

        for culture_id, title, story, contributor, _status in VALUES_STORY_RE.findall(text):
            culture_entry = local_culture_by_id.get(int(culture_id))
            if not culture_entry:
                continue
            records[culture_entry["country"]]["stories"].append(
                {
                    "title": _sql_unescape(title),
                    "text": _sql_unescape(story),
                    "contributor": _sql_unescape(contributor),
                    "culture": culture_entry["culture"],
                }
            )

    for record in records.values():
        record["cultures"] = sorted(set(record["cultures"]))
        record["phrases"] = _dedupe_dict_list(record["phrases"], ("culture", "native", "english"))
        record["traditions"] = _dedupe_dict_list(record["traditions"], ("culture", "title"))
        record["stories"] = _dedupe_dict_list(record["stories"], ("culture", "title"))

    return records


def build_data_by_iso3(geo):
    records_by_country = _build_country_records_from_sql()
    by_iso3 = {}

    for feature in geo.get("features", []):
        props = feature.get("properties", {})
        country_name = props.get("name") or props.get("ADMIN") or props.get("NAME") or ""
        iso3 = props.get(ISO_FIELD)
        if not iso3:
            continue

        country_record = records_by_country.get(_normalize_country_name(country_name))
        if not country_record:
            continue

        status = _status_from_risk_list(country_record["risk_levels"])
        score = RISK_SCORE.get(status.lower(), 0.3)
        cultures = country_record["cultures"]
        hotspots = country_record["hotspots"]
        phrases = country_record["phrases"]
        traditions = country_record["traditions"]
        stories = country_record["stories"]
        summary = (
            f"{len(cultures)} cultures, {len(hotspots)} hotspots, {len(stories)} stories from SQL seed data."
            if cultures or hotspots or stories
            else "No information available."
        )

        by_iso3[iso3] = {
            "score": score,
            "status": status,
            "summary": summary,
            "cultures": cultures,
            "hotspots": hotspots,
            "phrases": phrases,
            "traditions": traditions,
            "stories": stories,
        }

    return by_iso3


def lerp(a, b, t):
    return a + (b - a) * t


def hex_to_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))


def rgb_to_hex(rgb):
    r, g, b = (max(0, min(255, int(round(x)))) for x in rgb)
    return f"#{r:02x}{g:02x}{b:02x}"


def risk_to_color(score):
    if score is None:
        return NO_DATA_COLOR

    blue = hex_to_rgb("#3182ce")
    yellow = hex_to_rgb("#ffd200")
    red = hex_to_rgb("#d7191c")

    if score <= 0.5:
        t = score / 0.5
        rgb = (lerp(blue[0], yellow[0], t), lerp(blue[1], yellow[1], t), lerp(blue[2], yellow[2], t))
    else:
        t = (score - 0.5) / 0.5
        rgb = (lerp(yellow[0], red[0], t), lerp(yellow[1], red[1], t), lerp(yellow[2], red[2], t))

    return rgb_to_hex(rgb)


def load_geojson():
    with urlopen(GEOJSON_URL, timeout=30) as response:
        return json.load(response)


def apply_styles(geo, data_by_iso3, risk_to_color_fn):
    for f in geo["features"]:
        iso3 = f.get("properties", {}).get(ISO_FIELD)
        entry = data_by_iso3.get(iso3, {})
        score = entry.get("score", None)

        f["properties"]["_score"] = score
        f["properties"]["_status"] = entry.get("status", "No data")
        f["properties"]["_summary"] = entry.get("summary", "No information available.")
        f["properties"]["_cultures"] = entry.get("cultures", [])
        f["properties"]["_hotspots"] = entry.get("hotspots", [])
        f["properties"]["_phrases"] = entry.get("phrases", [])
        f["properties"]["_traditions"] = entry.get("traditions", [])
        f["properties"]["_stories"] = entry.get("stories", [])

        f["properties"]["style"] = {
            "fillColor": risk_to_color_fn(score),
            "color": "#444444",
            "weight": 1,
            "opacity": 1,
            "fillOpacity": 0.85,
        }
    return geo
