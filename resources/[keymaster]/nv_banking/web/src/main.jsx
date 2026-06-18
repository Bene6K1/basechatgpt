import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import store from './store/store.jsx'
import { Provider } from 'react-redux'
import { eventListener } from './hooks/eventListener.js'
import { HashRouter } from 'react-router-dom'
import './custom-theme.css'

function Root() {
    eventListener()

    return(
        <StrictMode>
            <HashRouter>
                <App />
            </HashRouter>
        </StrictMode>
    )
}

// Check if root already exists to prevent duplicate createRoot calls
const container = document.getElementById('root')
let root

if (container._reactRootContainer) {
    // Root already exists, use it
    root = container._reactRootContainer
} else {
    // Create new root
    root = createRoot(container)
    container._reactRootContainer = root
}

root.render(
    <Provider store={store}>
        <Root/>
    </Provider>
)