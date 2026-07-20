/* Purely visual layer: sparkles + icon flip on tap.
   Does not touch any display/tweak logic in script.js. */

function spawnSparkles(target, count) {
  const rect = target.getBoundingClientRect();
  const n = count || 6;
  for (let i = 0; i < n; i++) {
    const s = document.createElement("span");
    s.className = "sparkle";
    const angle = (Math.PI * 2 * i) / n + Math.random() * 0.4;
    const dist = 26 + Math.random() * 22;
    const dx = Math.cos(angle) * dist;
    const dy = Math.sin(angle) * dist;
    s.style.setProperty("--dx", dx + "px");
    s.style.setProperty("--dy", dy + "px");
    s.style.left = (rect.left + rect.width / 2) + "px";
    s.style.top = (rect.top + rect.height / 2) + "px";
    s.textContent = Math.random() > 0.5 ? "✦" : "✧";
    document.body.appendChild(s);
    s.addEventListener("animationend", () => s.remove());
  }
}

function bindTapEffects(selector) {
  document.querySelectorAll(selector).forEach(el => {
    el.addEventListener("click", () => {
      spawnSparkles(el, 7);
      el.classList.remove("flip-play");
      void el.offsetWidth; // restart animation
      el.classList.add("flip-play");
    });
  });
}

function showWelcomeOverlay() {
  const overlay = document.getElementById("welcomeOverlay");
  if (!overlay) return;
  requestAnimationFrame(() => overlay.classList.add("show"));
}

function hideWelcomeOverlay() {
  const overlay = document.getElementById("welcomeOverlay");
  if (!overlay) return;
  overlay.classList.remove("show");
}

function bindWelcomeOverlay() {
  const overlay = document.getElementById("welcomeOverlay");
  const closeBtn = document.getElementById("welcomeCloseBtn");
  if (!overlay || !closeBtn) return;

  closeBtn.addEventListener("click", hideWelcomeOverlay);
  overlay.addEventListener("click", (e) => {
    if (e.target === overlay) hideWelcomeOverlay();
  });

  showWelcomeOverlay();
}

document.addEventListener("DOMContentLoaded", () => {
  bindTapEffects("#applyBtn, #resetBtn, .fab-toggle");
  bindWelcomeOverlay();
});
