import React from "react";

function CountryPanel({ country }) {
  if (!country) {
    return (
      <section className="country-panel country-panel--empty">
        <h2>Country Intelligence</h2>
        <p>
          Select a country or pinpoint on the map to view database-backed
          language risk details and field notes.
        </p>
      </section>
    );
  }

  return (
    <section className="country-panel">
      <header className="country-panel__header">
        <h2>{country.name}</h2>
        <span className={`status-pill status-pill--${country.status}`}>
          {country.status.toUpperCase()}
        </span>
      </header>

      <div className="country-panel__grid">
        <div className="panel-metric">
          <span>Known Endangered Languages</span>
          <strong>{country.languageCount ?? "N/A"}</strong>
        </div>
        <div className="panel-metric">
          <span>High Risk Regions</span>
          <strong>{country.pinpoints?.length || 0}</strong>
        </div>
      </div>

      <div className="country-panel__section">
        <h3>Overview</h3>
        <p>{country.summary || "No summary available."}</p>
      </div>

      <div className="country-panel__section">
        <h3>Priority Notes</h3>
        {country.details?.length ? (
          <ul>
            {country.details.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        ) : (
          <p>No detailed notes found in the current dataset.</p>
        )}
      </div>

      <div className="country-panel__section">
        <h3>Regional Pinpoints</h3>
        {country.pinpoints?.length ? (
          <ul>
            {country.pinpoints.map((pin) => (
              <li key={pin.id}>
                <strong>{pin.label}:</strong> {pin.notes}
              </li>
            ))}
          </ul>
        ) : (
          <p>No regional markers available for this country.</p>
        )}
      </div>

      <div className="country-panel__section">
        <h3>Language Phrases</h3>
        {country.phrases?.length ? (
          <ul>
            {country.phrases.slice(0, 6).map((phrase) => (
              <li key={`${phrase.culture}-${phrase.native}-${phrase.english}`}>
                <strong>{phrase.native}</strong> - {phrase.english} ({phrase.culture})
              </li>
            ))}
          </ul>
        ) : (
          <p>No language phrase records found.</p>
        )}
      </div>

      <div className="country-panel__section">
        <h3>Traditions</h3>
        {country.traditions?.length ? (
          <ul>
            {country.traditions.slice(0, 6).map((tradition) => (
              <li key={`${tradition.culture}-${tradition.title}`}>
                <strong>{tradition.title}</strong> ({tradition.culture})
              </li>
            ))}
          </ul>
        ) : (
          <p>No tradition records found.</p>
        )}
      </div>

      <div className="country-panel__section">
        <h3>Stories</h3>
        {country.stories?.length ? (
          <ul>
            {country.stories.slice(0, 4).map((story) => (
              <li key={`${story.culture}-${story.title}`}>
                <strong>{story.title}</strong> ({story.culture})
                <p className="country-panel__story-text">
                  {story.text || "No story text available."}
                </p>
                {story.contributor ? (
                  <p className="country-panel__story-credit">
                    Contributor: {story.contributor}
                  </p>
                ) : null}
              </li>
            ))}
          </ul>
        ) : (
          <p>No story records found.</p>
        )}
      </div>
    </section>
  );
}

export default CountryPanel;
