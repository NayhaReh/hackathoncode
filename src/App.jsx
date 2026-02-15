import React, { useMemo, useState } from "react";
import MapView from "./src/components/MapView";
import CountryPanel from "./src/components/CountryPanel";
import Legend from "./src/components/Legend";
import { getStatusCounts } from "./src/data/mockCountries";
import "./App.css";

class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, message: "" };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, message: String(error?.message || error) };
  }

  componentDidCatch(error, info) {
    console.error("UI crash captured by ErrorBoundary:", error, info);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ padding: "1rem", color: "#7f1d1d", background: "#ffe4e6", borderRadius: "10px" }}>
          <strong>Map failed to render.</strong>
          <p style={{ margin: "0.5rem 0 0" }}>{this.state.message}</p>
          <p style={{ margin: "0.5rem 0 0" }}>
            Open browser Console and share the first red error line.
          </p>
        </div>
      );
    }
    return this.props.children;
  }
}

function App() {
  const [selectedCountry, setSelectedCountry] = useState(null);
  const [countries, setCountries] = useState([]);
  const metrics = useMemo(() => getStatusCounts(countries), [countries]);

  return (
    <div className="app-shell">
      <div className="app-shell__background" />

      <header className="topbar">
        <div>
          <p className="topbar__eyebrow">Endangered Language Observatory</p>
          <h1>Global Risk Intelligence Dashboard</h1>
        </div>

        <div className="topbar__kpis">
          <div className="kpi-card">
            <span>Total Countries</span>
            <strong>{metrics.total}</strong>
          </div>
          <div className="kpi-card kpi-card--high">
            <span>High Risk</span>
            <strong>{metrics.high}</strong>
          </div>
          <div className="kpi-card kpi-card--medium">
            <span>Medium Risk</span>
            <strong>{metrics.medium}</strong>
          </div>
          <div className="kpi-card kpi-card--normal">
            <span>Normal</span>
            <strong>{metrics.normal}</strong>
          </div>
        </div>
      </header>

      <main className="layout">
        <section className="map-card">
          <div className="map-card__header">
            <h2>Global Map View</h2>
            <p>Country risk gradient, labels, and pinpoint language hotspots.</p>
          </div>

          <div className="map-card__body">
            <ErrorBoundary>
              <MapView
                onCountryClick={setSelectedCountry}
                onCountriesLoaded={setCountries}
              />
            </ErrorBoundary>
            <Legend />
          </div>
        </section>

        <aside className="panel-card">
          <CountryPanel country={selectedCountry} />
        </aside>
      </main>
    </div>
  );
}

export default App;
