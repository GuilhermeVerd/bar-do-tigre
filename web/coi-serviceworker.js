/*! coi-serviceworker v0.1.7 - Guido Zuidhof, licensed under MIT */
/*! Updated to include Flutter-friendly behavior */
let coepCredentialless = false;
if (typeof window === 'undefined') {
    self.addEventListener("install", () => self.skipWaiting());
    self.addEventListener("activate", event => event.waitUntil(self.clients.claim()));
    self.addEventListener("message", (ev) => {
        if (!ev.data) return;
        if (ev.data.type === "deregister") self.registration.unregister();
        else if (ev.data.type === "coepCredentialless") coepCredentialless = ev.data.value;
    });
    self.addEventListener("fetch", (event) => {
        const r = event.request;
        if (r.cache === "only-if-cached" && r.mode !== "same-origin") return;
        const req = coepCredentialless && r.mode === "no-cors"
            ? new Request(r, { credentials: "omit" })
            : r;
        event.respondWith((async () => {
            if (req.mode === "no-cors" && req.destination !== "script" && req.destination !== "style" && req.destination !== "image" && req.destination !== "font") {
                try {
                    const resp = await fetch(req);
                    const h = new Headers(resp.headers);
                    h.set("Cross-Origin-Embedder-Policy", coepCredentialless ? "credentialless" : "require-corp");
                    h.set("Cross-Origin-Opener-Policy", "same-origin");
                    return new Response(resp.body, { status: resp.status, statusText: resp.statusText, headers: h });
                } catch (e) {
                    return new Response("Server unavailable", { status: 502, statusText: "Bad Gateway", headers: { "Cross-Origin-Embedder-Policy": coepCredentialless ? "credentialless" : "require-corp", "Cross-Origin-Opener-Policy": "same-origin" } });
                }
            }
            try {
                const resp = await fetch(req);
                const h = new Headers(resp.headers);
                h.set("Cross-Origin-Embedder-Policy", coepCredentialless ? "credentialless" : "require-corp");
                h.set("Cross-Origin-Opener-Policy", "same-origin");
                return new Response(resp.body, { status: resp.status, statusText: resp.statusText, headers: h });
            } catch (e) {
                return new Response("Server unavailable", { status: 502, statusText: "Bad Gateway", headers: { "Cross-Origin-Embedder-Policy": coepCredentialless ? "credentialless" : "require-corp", "Cross-Origin-Opener-Policy": "same-origin" } });
            }
        })());
    });
} else {
    (async () => {
        try {
            const reg = await navigator.serviceWorker.register(document.currentScript.src);
            await navigator.serviceWorker.ready;
            if (reg.installing) reg.installing.postMessage({ type: "coepCredentialless", value: coepCredentialless });
            else if (reg.waiting) reg.waiting.postMessage({ type: "coepCredentialless", value: coepCredentialless });
            else if (reg.active) reg.active.postMessage({ type: "coepCredentialless", value: coepCredentialless });
            if (!window.crossOriginIsolated) {
                let reloaded = false;
                const handler = () => { if (!reloaded) { reloaded = true; location.reload(); } };
                navigator.serviceWorker.addEventListener("controllerchange", handler);
                setTimeout(handler, 2500);
            }
        } catch (e) { /* noop */ }
    })();
}
