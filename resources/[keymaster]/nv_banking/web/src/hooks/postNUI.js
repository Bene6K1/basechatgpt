var resourceName = "oph3z-bank";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

const postNUI = async (name, data) => {
    console.log('postNUI', name, resourceName)
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {}
}

window.postNUI = postNUI;

export default postNUI;