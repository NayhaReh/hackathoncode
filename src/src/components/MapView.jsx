import React, { useEffect, useMemo, useState } from "react";
import {
  CircleMarker,
  GeoJSON,
  MapContainer,
  Popup,
  TileLayer,
  Tooltip,
} from "react-leaflet";
import { fetchCountries } from "../services/countryService";

const STATUS_COLORS = {
  high: "#cf2f2f",
  medium: "#eab22d",
  normal: "#3182ce",
};

function getStatusColor(status) {
  return STATUS_COLORS[status] || STATUS_COLORS.normal;
}

function getCountryStyle(feature) {
  const status = feature?.properties?.status || "normal";
  return {
    fillColor: getStatusColor(status),
    weight: 0.9,
    opacity: 1,
    color: "#e7edf6",
    fillOpacity: 0.62,
  };
}

function MapView({ onCountryClick, onCountriesLoaded }) {
  const [countries, setCountries] = useState([]);

  useEffect(() => {
    let active = true;

    fetchCountries()
      .then((payload) => {
        if (!active) return;
        setCountries(payload);
        onCountriesLoaded?.(payload);
      })
      .catch((error) => {
        console.error("Failed to load countries", error);
      });

    return () => {
      active = false;
    };
  }, [onCountriesLoaded]);

  const features = useMemo(() => {
    return countries
      .filter((country) => country.geometry)
      .map((country) => ({
        type: "Feature",
        geometry: country.geometry,
        properties: {
          id: country.id,
          name: country.name,
          status: country.status,
        },
      }));
  }, [countries]);

  const pinpoints = useMemo(() => {
    return countries.flatMap((country) =>
      (country.pinpoints || []).map((pin) => ({
        ...pin,
        countryName: country.name,
        status: country.status,
        countryId: country.id,
      })),
    );
  }, [countries]);

  const countryById = useMemo(() => {
    return new Map(countries.map((country) => [country.id, country]));
  }, [countries]);

  return (
    <MapContainer
      center={[22, 9]}
      zoom={2.1}
      minZoom={2}
      maxZoom={8}
      worldCopyJump
      className="map-view"
    >
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />

      {features.length > 0 && (
        <GeoJSON
          data={{ type: "FeatureCollection", features }}
          style={getCountryStyle}
          onEachFeature={(feature, layer) => {
            const country = countryById.get(feature.properties.id);

            layer.bindTooltip(feature.properties.name, {
              direction: "center",
              permanent: false,
              opacity: 0.9,
              className: "country-label",
              sticky: true,
            });

            layer.on({
              click: () => onCountryClick?.(country),
              mouseover: () => layer.setStyle({ weight: 1.4, fillOpacity: 0.78 }),
              mouseout: () => layer.setStyle(getCountryStyle(feature)),
            });
          }}
        />
      )}

      {pinpoints.map((pin) => (
        <CircleMarker
          key={`${pin.countryId}-${pin.id}`}
          center={[pin.lat, pin.lng]}
          radius={7}
          pathOptions={{
            color: "#0f172a",
            weight: 1,
            fillColor: getStatusColor(pin.status),
            fillOpacity: 0.95,
          }}
          eventHandlers={{
            click: () => onCountryClick?.(countryById.get(pin.countryId)),
          }}
        >
          <Tooltip direction="top" offset={[0, -6]} opacity={0.9}>
            {pin.label}
          </Tooltip>
          <Popup>
            <div className="pin-popup">
              <h4>{pin.label}</h4>
              <p>{pin.countryName}</p>
              <p>{pin.notes}</p>
            </div>
          </Popup>
        </CircleMarker>
      ))}
    </MapContainer>
  );
}

export default MapView;
