 # static/components/map.py
import dash_leaflet as dl

def build_map(geo):
    return dl.Map(
        center=[20, 0],
        zoom=2,
        className="map",
        children=[
            dl.TileLayer(url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"),
            dl.GeoJSON(
                id="countries",
                data=geo,
                hoverStyle={"weight": 2, "color": "#111111"},
            ),
        ],
    )