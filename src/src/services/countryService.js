import { mockCountries, normalizeStatus } from "../data/mockCountries";

function normalizeCountry(country, index) {
  return {
    id: country.id || `country-${index}`,
    name: country.name || "Unknown Country",
    status: normalizeStatus(country.status),
    summary: country.summary || "",
    details: Array.isArray(country.details) ? country.details : [],
    languageCount: country.languageCount ?? null,
    geometry: country.geometry || null,
    stories: Array.isArray(country.stories) ? country.stories : [],
    traditions: Array.isArray(country.traditions) ? country.traditions : [],
    phrases: Array.isArray(country.phrases) ? country.phrases : [],
    pinpoints: Array.isArray(country.pinpoints)
      ? country.pinpoints.filter(
          (pin) =>
            typeof pin.lat === "number" &&
            typeof pin.lng === "number" &&
            pin.label,
        )
      : [],
  };
}

function normalizeCountries(payload) {
  if (!Array.isArray(payload)) {
    return [];
  }

  return payload.map(normalizeCountry);
}

export async function fetchCountries() {
  try {
    const response = await fetch("/api/countries");
    if (!response.ok) {
      throw new Error(`Unexpected status: ${response.status}`);
    }
    const data = await response.json();
    const normalized = normalizeCountries(data);

    return normalized.length > 0
      ? normalized
      : normalizeCountries(mockCountries);
  } catch (error) {
    console.warn("Falling back to local mock country dataset.", error);
    return normalizeCountries(mockCountries);
  }
}
