import { useEffect, useRef } from "react";
import { noop } from "../utils/misc";

interface NuiMessageData<T = any> {
  action: string;
  data: T;
}

export const useNuiEvent = <T = any>(action: string, handler: (data: T) => void) => {
  const savedHandler = useRef<(data: T) => void>(noop);

  useEffect(() => {
    savedHandler.current = handler;
  }, [handler]);

  useEffect(() => {
    const eventListener = (event: MessageEvent<NuiMessageData<T>>) => {
      const { action: eventAction, data } = event.data;

      if (savedHandler.current && eventAction === action) {
        savedHandler.current(data);
      }
    };

    window.addEventListener("message", eventListener);
    return () => window.removeEventListener("message", eventListener);
  }, [action]);
};
