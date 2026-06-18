import React, { Context, createContext, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";

interface VisibilityProviderValue {
  visible: boolean;
  setVisible: (visible: boolean) => void;
}

export const VisibilityContext: Context<VisibilityProviderValue | null> =
  createContext<VisibilityProviderValue | null>(null);

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  // En mode développement (navigateur), on est visible par défaut
  const [visible, setVisible] = useState(isEnvBrowser());

  useNuiEvent<boolean>("setVisible", setVisible);

  return (
    <VisibilityContext.Provider value={{ visible, setVisible }}>
      <div style={{ visibility: visible ? "visible" : "hidden", height: "100%" }}>
        {children}
      </div>
    </VisibilityContext.Provider>
  );
};
