export const mockCountries = [
  {
    id: "USA",
    name: "United States",
    status: "medium",
    languageCount: 170,
    summary:
      "Several Indigenous languages remain under severe pressure despite regional revitalization programs.",
    details: [
      "Intergenerational transfer remains fragile in multiple tribal communities.",
      "Community school immersion initiatives are growing in the Southwest and Pacific Northwest.",
      "Funding continuity is the primary risk factor for long-term recovery.",
    ],
    geometry: {
      type: "Polygon",
      coordinates: [
        [
          [-125, 24],
          [-66, 24],
          [-66, 49],
          [-125, 49],
          [-125, 24],
        ],
      ],
    },
    pinpoints: [
      {
        id: "usa-1",
        label: "Navajo Nation",
        lat: 36.2,
        lng: -109.5,
        notes: "Strong speaker base but youth fluency is uneven.",
      },
      {
        id: "usa-2",
        label: "Alaska Native Regions",
        lat: 64.8,
        lng: -152.5,
        notes: "Many small communities report acute elder-speaker concentration.",
      },
    ],
  },
  {
    id: "BRA",
    name: "Brazil",
    status: "high",
    languageCount: 190,
    summary:
      "Deforestation and displacement correlate with accelerated language attrition in remote territories.",
    details: [
      "Documentation gaps remain large in interior regions.",
      "Language vitality differs sharply by state-level policy support.",
      "Urban migration is increasing language shift rates.",
    ],
    geometry: {
      type: "Polygon",
      coordinates: [
        [
          [-74, -34],
          [-34, -34],
          [-34, 5],
          [-74, 5],
          [-74, -34],
        ],
      ],
    },
    pinpoints: [
      {
        id: "bra-1",
        label: "Amazon Basin",
        lat: -3.1,
        lng: -62.3,
        notes: "Remote communities face highest operational risk for ongoing teaching programs.",
      },
      {
        id: "bra-2",
        label: "Mato Grosso",
        lat: -13.2,
        lng: -56.1,
        notes: "Rapid land-use change impacts smaller language groups.",
      },
    ],
  },
  {
    id: "NGA",
    name: "Nigeria",
    status: "high",
    languageCount: 520,
    summary:
      "Nigeria has very high language diversity with uneven education coverage for minority language communities.",
    details: [
      "Urban schooling often prioritizes dominant languages.",
      "Conflict-affected zones show weak continuity in local-language education.",
      "Civil society groups are expanding dictionary and archive projects.",
    ],
    geometry: {
      type: "Polygon",
      coordinates: [
        [
          [2, 4],
          [15, 4],
          [15, 14],
          [2, 14],
          [2, 4],
        ],
      ],
    },
    pinpoints: [
      {
        id: "nga-1",
        label: "Middle Belt",
        lat: 8.9,
        lng: 8.7,
        notes: "Many communities have limited formal learning material.",
      },
    ],
  },
  {
    id: "IND",
    name: "India",
    status: "medium",
    languageCount: 450,
    summary:
      "Large multilingual landscape with fast social change; many minority languages show declining home usage.",
    details: [
      "Northeast and Himalayan regions show mixed resilience outcomes.",
      "Digital content access is improving language visibility.",
      "Teacher training capacity remains inconsistent across states.",
    ],
    geometry: {
      type: "Polygon",
      coordinates: [
        [
          [68, 8],
          [97, 8],
          [97, 36],
          [68, 36],
          [68, 8],
        ],
      ],
    },
    pinpoints: [
      {
        id: "ind-1",
        label: "Northeast States",
        lat: 26.2,
        lng: 93.9,
        notes: "Several language communities are piloting literacy programs.",
      },
      {
        id: "ind-2",
        label: "Central Tribal Belt",
        lat: 21.5,
        lng: 81.6,
        notes: "Language transmission is increasingly mixed in peri-urban districts.",
      },
    ],
  },
  {
    id: "AUS",
    name: "Australia",
    status: "normal",
    languageCount: 120,
    summary:
      "Revitalization efforts are active, though many languages still rely on small elder communities.",
    details: [
      "Community-led archival programs show strong momentum.",
      "School integration is improving in selected territories.",
      "Rural service coverage remains uneven.",
    ],
    geometry: {
      type: "Polygon",
      coordinates: [
        [
          [113, -44],
          [154, -44],
          [154, -10],
          [113, -10],
          [113, -44],
        ],
      ],
    },
    pinpoints: [
      {
        id: "aus-1",
        label: "Northern Territory",
        lat: -19.4,
        lng: 133.5,
        notes: "Multiple active revitalization partnerships are underway.",
      },
    ],
  },
];

export function normalizeStatus(value) {
  const normalized = String(value || "normal").toLowerCase().trim();
  if (normalized === "high" || normalized === "medium") {
    return normalized;
  }
  return "normal";
}

export function getStatusCounts(countries) {
  return countries.reduce(
    (acc, country) => {
      const status = normalizeStatus(country.status);
      acc.total += 1;
      acc[status] += 1;
      return acc;
    },
    { total: 0, high: 0, medium: 0, normal: 0 },
  );
}
