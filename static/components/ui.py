 # static/components/ui.py
from dash import html

def build_layout(map_component, panel_component):
    return html.Div(
        className="layout",
        children=[map_component, panel_component],
    )

def build_legend():
    return html.Div(
        className="legendBlock",
        children=[
            html.Div("Legend", className="legendTitle"),
            html.Div(className="legendBar"),
            html.Div(
                className="legendLabels",
                children=[html.Small("Low"), html.Small("Medium"), html.Small("High")],
            ),
        ],
    )