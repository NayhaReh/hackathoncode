 # static/components/panel.py
from dash import html, Output, Input

def build_panel(legend_component):
    return html.Aside(
        className="panel",
        children=[
            html.H3("Country Info", style={"marginTop": 0}),
            html.Div(id="panel", children="Click a country to see details."),
            html.Hr(),
            legend_component,
        ],
    )

def register_panel_callbacks(app, ISO_FIELD, risk_to_color):
    @app.callback(Output("panel", "children"), Input("countries", "click_feature"))
    def show_country_info(feature):
        if not feature:
            return "Click a country to see details."

        props = feature.get("properties", {})
        name = props.get("name") or props.get("ADMIN") or props.get("NAME") or "Unknown"
        iso3 = props.get(ISO_FIELD) or "—"
        status = props.get("_status", "No data")
        summary = props.get("_summary", "No information available.")
        cultures = props.get("_cultures", [])
        score = props.get("_score", None)

        swatch = html.Span(
            className="swatch",
            style={"backgroundColor": risk_to_color(score) if score is not None else "#d9d9d9"},
        )

        return html.Div(
            [
                html.Div([swatch, html.Strong(name)], className="panelTitleRow"),
                html.P([html.B("ISO3: "), iso3]),
                html.P([html.B("Status: "), status]),
                html.P(summary),
                html.H4("Endangered cultures") if cultures else html.Div(),
                html.Ul([html.Li(c) for c in cultures]) if cultures else html.Small("No list available."),
            ]
        )
