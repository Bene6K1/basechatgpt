import React from "react";
import { Route, Switch, useHistory } from "react-router-dom";
import Prompt from "./components/Prompt";
import { useNuiEvent } from "./hooks/useNuiEvent";

const App: React.FC = () => {
  const history = useHistory();

  useNuiEvent<string>("setPage", (page) => {
    history.push("/" + page);
  });

  return (
    <>
      <Switch>
        <Route exact path="/" component={Prompt} />
        <Route exact path="/web/build/index.html" component={Prompt} />
      </Switch>
    </>
  );
};

export default App;
