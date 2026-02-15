# app.py
from dash import Dash
from flask import jsonify
from static.components.data import load_geojson, apply_styles, ISO_FIELD, risk_to_color, build_data_by_iso3
from static.components.map import build_map
from static.components.panel import build_panel, register_panel_callbacks
from static.components.ui import build_layout, build_legend

# Dash will load CSS from static/assets/styles.css
app = Dash(__name__, assets_folder="static/assets")
server = app.server

# Load + style geojson
geo = load_geojson()
DATA_BY_ISO3 = build_data_by_iso3(geo)
geo = apply_styles(geo, DATA_BY_ISO3, risk_to_color)

# Build UI parts
map_component = build_map(geo)
legend_component = build_legend()
panel_component = build_panel(legend_component)

# Layout
app.layout = build_layout(map_component, panel_component)

# Callbacks
register_panel_callbacks(app, ISO_FIELD, risk_to_color)


def _normalize_status(status):
    normalized = str(status or "Normal").strip().lower()
    if normalized == "high":
        return "high"
    if normalized == "medium":
        return "medium"
    return "normal"


def _extract_points(geometry):
    if not geometry:
        return []

    gtype = geometry.get("type")
    coords = geometry.get("coordinates", [])

    if gtype == "Polygon":
        return coords[0] if coords else []
    if gtype == "MultiPolygon":
        points = []
        for polygon in coords:
            if polygon and polygon[0]:
                points.extend(polygon[0])
        return points

    return []


def _compute_centroid(geometry):
    points = _extract_points(geometry)
    if not points:
        return None

    lng_sum = 0.0
    lat_sum = 0.0
    valid_points = 0

    for point in points:
        if isinstance(point, list) and len(point) >= 2:
            lng_sum += point[0]
            lat_sum += point[1]
            valid_points += 1

    if valid_points == 0:
        return None

    return {"lat": lat_sum / valid_points, "lng": lng_sum / valid_points}


@server.get("/api/countries")
def countries_api():
    countries = []

    for feature in geo.get("features", []):
        props = feature.get("properties", {})
        geometry = feature.get("geometry")
        iso3 = props.get(ISO_FIELD)

        entry = DATA_BY_ISO3.get(iso3, {})
        if not entry:
            continue
        status = _normalize_status(entry.get("status"))
        summary = entry.get("summary", "No information available.")
        details = entry.get("cultures", [])
        hotspots = entry.get("hotspots", [])
        stories = entry.get("stories", [])
        traditions = entry.get("traditions", [])
        phrases = entry.get("phrases", [])
        name = props.get("name") or props.get("ADMIN") or props.get("NAME") or iso3 or "Unknown Country"

        pinpoints = []
        for index, hotspot in enumerate(hotspots):
            pinpoints.append(
                {
                    "id": f"{iso3 or 'UNK'}-{index}",
                    "label": hotspot.get("label", f"{name} hotspot"),
                    "lat": hotspot.get("lat"),
                    "lng": hotspot.get("lng"),
                    "notes": f"Risk: {hotspot.get('risk_level', 'n/a')}",
                }
            )

        if not pinpoints and entry:
            centroid = _compute_centroid(geometry)
            if centroid:
                pinpoints.append(
                    {
                        "id": f"{iso3 or 'UNK'}-center",
                        "label": f"{name} Center",
                        "lat": centroid["lat"],
                        "lng": centroid["lng"],
                        "notes": summary,
                    }
                )

        countries.append(
            {
                "id": iso3 or name,
                "name": name,
                "status": status,
                "summary": summary,
                "details": details,
                "languageCount": len(details),
                "geometry": geometry,
                "pinpoints": pinpoints,
                "stories": stories,
                "traditions": traditions,
                "phrases": phrases,
            }
        )

    return jsonify(countries)


if __name__ == "__main__":
    app.run(debug=True)
