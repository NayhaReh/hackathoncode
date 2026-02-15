import React from "react";

function Legend() {
  return (
    <aside className="legend">
      <h3>Risk Gradient</h3>
      <ul>
        <li>
          <span className="legend-dot legend-dot--high" />
          High Risk
        </li>
        <li>
          <span className="legend-dot legend-dot--medium" />
          Medium Risk
        </li>
        <li>
          <span className="legend-dot legend-dot--normal" />
          Normal
        </li>
      </ul>
      <p>Click country shapes or pins for deeper country-level details.</p>
    </aside>
  );
}

export default Legend;
