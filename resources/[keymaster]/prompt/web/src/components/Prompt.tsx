import React, { useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import "./Prompt.css";

interface PromptData {
  show: boolean;
  title: string;
  description: string;
  description2: string;
}

const Prompt: React.FC = () => {
  const [promptData, setPromptData] = useState<PromptData>({
    show: true,
    title: "N E V A",
    description: "Êtes-vous sûr de vouloir définir ce grade pour ce joueur ?",
    description2: "Cacacacacac",
  });
  const [isFading, setIsFading] = useState(false);

  useNuiEvent<Omit<PromptData, "show">>("createPrompt", (data) => {
    // Regex patterns for text formatting
    const colorPattern = /~([^h])~([^~]+)/g;
    const highlightPattern = /~([h])~([^~]+)/g;
    const strikePattern = /~s~/g;
    const newlinePattern = /\n/g;

    // Format title
    data.title = data.title
      .replace(colorPattern, "<span class='$1'>$2</span>")
      .replace(highlightPattern, "<span class='$1'>$2</span>")
      .replace(strikePattern, "")
      .replace(newlinePattern, "<br />");

    // Format description
    data.description = data.description
      .replace(colorPattern, "<span class='$1'>$2</span>")
      .replace(highlightPattern, "<span class='$1'>$2</span>")
      .replace(strikePattern, "")
      .replace(newlinePattern, "<br />");

    // Format description2
    data.description2 = data.description2
      .replace(colorPattern, "<span class='$1'>$2</span>")
      .replace(highlightPattern, "<span class='$1'>$2</span>")
      .replace(strikePattern, "")
      .replace(newlinePattern, "<br />");

    setIsFading(false);
    setPromptData({ ...data, show: true });
  });

  useEffect(() => {
    if (promptData.show) {
      const handleKeyPress = (event: KeyboardEvent) => {
        if (["KeyY", "KeyN"].includes(event.code)) {
          setIsFading(true);
          setTimeout(() => {
            if (event.code === "KeyY") {
              fetchNui("prompt:accept");
            } else {
              fetchNui("prompt:refuse");
            }
            setPromptData((prev) => ({ ...prev, show: false }));
          }, 300);
        }
      };

      window.addEventListener("keydown", handleKeyPress);
      return () => window.removeEventListener("keydown", handleKeyPress);
    }
  }, [promptData]);

  if (!promptData.show && !isFading) {
    return null;
  }

  const handleAccept = () => {
    setIsFading(true);
    setTimeout(() => {
      fetchNui("prompt:accept");
      setPromptData((prev) => ({ ...prev, show: false }));
    }, 300);
  };

  const handleRefuse = () => {
    setIsFading(true);
    setTimeout(() => {
      fetchNui("prompt:refuse");
      setPromptData((prev) => ({ ...prev, show: false }));
    }, 300);
  };

  return (
    <div className={`prompt-container ${isFading ? "fade-out" : ""}`}>
      <div className="prompt-card">

        <div className="prompt-header">
          <div className="prompt-icon-container">
            <img src="airplay-audio-duotone-solid-full.svg" alt="question" className="prompt-icon" />
          </div>
          <h1 className="prompt-title" dangerouslySetInnerHTML={{ __html: promptData.title }} />
        </div>

        <div className="prompt-content">
          <p className="prompt-description" dangerouslySetInnerHTML={{ __html: promptData.description }} />
          {promptData.description2 && (
            <p className="prompt-description2" dangerouslySetInnerHTML={{ __html: promptData.description2 }} />
          )}
        </div>

        <div className="prompt-buttons">
          <button className="prompt-button prompt-button-accept" onClick={handleAccept}>
            Accepter
            <span className="prompt-key-icon">Y</span>
          </button>
          <button className="prompt-button prompt-button-refuse" onClick={handleRefuse}>
            Refuser
            <span className="prompt-key-icon">N</span>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Prompt;
