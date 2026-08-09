// ==UserScript==
// @name         Safe Redirect Helper
// @namespace    local.safe.redirect
// @version      1.0.0
// @description  Simple client-side redirect helper
// @match        *://example.com/*
// @run-at       document-start
// ==/UserScript==

(() => {
    'use strict';

    const params = new URLSearchParams(window.location.search);
    const redirect = params.get('redirect');

    if (!redirect) return;

    let target;

    try {
        target = new URL(redirect, window.location.origin);
    } catch {
        console.error('Invalid redirect URL');
        return;
    }

    // Разрешаем только обычные HTTP/HTTPS ссылки
    if (!['http:', 'https:'].includes(target.protocol)) {
        console.error('Blocked unsupported protocol');
        return;
    }

    const container = document.createElement('div');

    container.innerHTML = `
        <div style="
            position:fixed;
            inset:0;
            z-index:999999;
            display:flex;
            align-items:center;
            justify-content:center;
            background:#111;
            color:#fff;
            font-family:Arial,sans-serif;
        ">
            <div style="
                width:360px;
                padding:30px;
                text-align:center;
                background:#1c1c1c;
                border-radius:16px;
                box-shadow:0 10px 40px rgba(0,0,0,.5);
            ">
                <h2>Redirect</h2>
                <p id="status">Ready to continue</p>

                <button id="continue" style="
                    padding:12px 25px;
                    border:0;
                    border-radius:8px;
                    background:#5865f2;
                    color:white;
                    cursor:pointer;
                    font-size:16px;
                ">
                    Continue
                </button>
            </div>
        </div>
    `;

    const show = () => {
        if (document.body) {
            document.body.appendChild(container);
        } else {
            document.documentElement.appendChild(container);
        }
    };

    show();

    container.querySelector('#continue').addEventListener('click', () => {
        const status = container.querySelector('#status');
        status.textContent = 'Redirecting...';

        setTimeout(() => {
            window.location.assign(target.href);
        }, 300);
    });
})();