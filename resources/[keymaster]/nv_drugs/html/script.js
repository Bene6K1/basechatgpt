// ============================
// UI XP existante
// ============================
window.addEventListener('message', (event) => {
  const data = event.data;

  if (data.action === 'show') {
    document.getElementById('exp-container').style.display = 'block';

    const xp = data.xp;
    const currentLevel = data.currentLevel;
    const xpCurrentLevel = data.xpCurrentLevel;
    const xpNextLevel = data.xpNextLevel;

    document.getElementById('level-bubble').textContent = currentLevel;

    let xpIntoLevel = xp - xpCurrentLevel;
    let xpNeededForNext = xpNextLevel - xpCurrentLevel;
    if (xpNeededForNext <= 0) {
      xpNeededForNext = 1;
      xpIntoLevel = 1;
    }

    let progressPercent = (xpIntoLevel / xpNeededForNext) * 100;
    if (progressPercent > 100) progressPercent = 100;
    document.getElementById('exp-fill').style.width = progressPercent + '%';
    document.getElementById('exp-text').textContent = `${xpIntoLevel}/${xpNeededForNext} XP`;

  } else if (data.action === 'hide') {
    document.getElementById('exp-container').style.display = 'none';
  }
});

// ============================
// Canvas Territoires (DUI uniquement)
// ============================
const isDui = (typeof GetParentResourceName === 'undefined');
const canvas = isDui ? document.createElement('canvas') : null;
if (isDui && canvas) {
  canvas.id = 'territory-canvas';
  canvas.style.display = 'block';
  canvas.style.position = 'absolute';
  canvas.style.top = '0';
  canvas.style.left = '0';
  canvas.style.width = '100%';
  canvas.style.height = '100%';
  canvas.style.background = 'transparent';
  document.body.appendChild(canvas);
}
if (typeof GetParentResourceName !== 'undefined') {
  try {
    fetch(`https://${GetParentResourceName()}/uiReady`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: JSON.stringify({ ctx: 'boot' })
    });
  } catch (e) {
    console.log('[nvTerritory:UI] POST uiReady failed', e);
  }
} else {
  // silence: pas de log en DUI pour éviter le bruit
}
const ctx = isDui && canvas ? canvas.getContext('2d') : null;

function setCanvasSize(w, h) {
  if (!isDui || !canvas) return;
  if (canvas.width !== w || canvas.height !== h) {
    canvas.width = w;
    canvas.height = h;
    // console.log('[nvTerritory:UI] canvas resized', w, h);
  }
}

function clearCanvas() {
  if (!isDui || !canvas) return;
  ctx.clearRect(0, 0, canvas.width, canvas.height);
}

function drawTerritoryPolygon(payload) {
  if (!isDui) return;
  const width = payload.width || 1024;
  const height = payload.height || 1024;
  const safeW = Math.max(64, Number(width) || 1024);
  const safeH = Math.max(64, Number(height) || 1024);
  setCanvasSize(safeW, safeH);
  clearCanvas();

  if (!payload || !Array.isArray(payload.points) || payload.points.length < 3) {
    // console.log('[nvTerritory:UI] invalid payload or points', payload);
    return;
  }

  const minX = payload.bbox.minX, maxX = payload.bbox.maxX;
  const minY = payload.bbox.minY, maxY = payload.bbox.maxY;
  const scaleX = safeW / Math.max(0.0001, (maxX - minX));
  const scaleY = safeH / Math.max(0.0001, (maxY - minY));

  // Optionnel: logs debug
  // console.log('[nvTerritory:UI] drawPolygon', payload.name, { width, height, minX, minY, maxX, maxY, points: payload.points.length });

  // Styles: gris (libre) par défaut, rouge si contrôlé
  // Style côté payload prioritaire (si fourni) sinon fixe
  const isControlled = (payload.controlled === true || payload.controlled === 1 || payload.controlled === 'true');
  // Fallback NUI: rouge si contrôlé, bleu ciel si libre
  const fill = payload.fill || (isControlled ? { r: 220, g: 30, b: 30, a: 0.35 } : { r: 80, g: 180, b: 255, a: 0.35 });
  const stroke = payload.stroke || { r: 255, g: 255, b: 255, a: 0.9, width: 2 };

  if (payload && payload.name === 'Mirror Park') {
    try { console.log('[nvTerritory:UI] drawPolygon Mirror Park controlled=', isControlled, 'fill=', JSON.stringify(fill)); } catch(e) {}
  }

  // Hinting pour éviter les bords flous
  ctx.save();
  ctx.imageSmoothingEnabled = true;
  ctx.imageSmoothingQuality = 'high';

  ctx.beginPath();
  const canvasPts = [];
  for (let i = 0; i < payload.points.length; i++) {
    const p = payload.points[i];
    const x = (p.x - minX) * scaleX;
    const y = (maxY - p.y) * scaleY; // invert Y to match map
    canvasPts.push({x, y});
    if (i === 0) ctx.moveTo(x, y);
    else ctx.lineTo(x, y);
  }
  ctx.closePath();

  ctx.fillStyle = `rgba(${fill.r}, ${fill.g}, ${fill.b}, ${fill.a})`;
  ctx.fill();

  ctx.lineWidth = stroke.width;
  ctx.strokeStyle = `rgba(${stroke.r}, ${stroke.g}, ${stroke.b}, ${stroke.a})`;
  ctx.stroke();
  ctx.restore();

  // Logo centré si territoire contrôlé et logo fourni
  try {
    const isControlled = (payload.controlled === true || payload.controlled === 1 || payload.controlled === 'true');
    const canShow = (payload.showLogo !== false);
    const primary = payload.crewLogoRaw || payload.crewLogo; // priorité au nom exact du crew
    const fallback = payload.crewLogoRaw ? (payload.crewLogo || null) : null; // si on a le raw, on tente sinon la version normalisée
    if (canShow && isControlled && primary) {
      // Centroid (shoelace) sur les points canvas
      let area = 0, cx = 0, cy = 0;
      for (let i = 0, j = canvasPts.length - 1; i < canvasPts.length; j = i++) {
        const p0 = canvasPts[j], p1 = canvasPts[i];
        const f = (p0.x * p1.y - p1.x * p0.y);
        area += f;
        cx += (p0.x + p1.x) * f;
        cy += (p0.y + p1.y) * f;
      }
      area *= 0.5;
      let centerX = safeW / 2, centerY = safeH / 2;
      if (Math.abs(area) > 1e-3) {
        cx = cx / (6 * area);
        cy = cy / (6 * area);
        centerX = cx; centerY = cy;
      }
      const drawImg = (src) => {
        const img = new Image();
        let triedFallback = false;
        img.onload = () => {
          // Taille logo proportionnelle à l'aire du polygone (single polygon path)
          const bboxArea = Math.max(1, safeW * safeH);
          const polyAreaAbs = Math.abs(area);
          const areaRatio = Math.min(1, Math.max(0.02, polyAreaAbs / bboxArea));
          const base = Math.min(safeW, safeH);
          // Valeurs par défaut si non batch: min 8%, max 18%
          const minPct = 0.08, maxPct = 0.18;
          const scaled = base * (minPct + (maxPct - minPct) * areaRatio);
          const size = Math.round(Math.max(base * minPct, Math.min(base * maxPct, scaled)));
          const drawW = size;
          const drawH = size;
          const dx = Math.floor(centerX - drawW / 2);
          const dy = Math.floor(centerY - drawH / 2);
          ctx.save();
          ctx.globalAlpha = 0.95;
          ctx.drawImage(img, dx, dy, drawW, drawH);
          ctx.restore();
        };
        img.onerror = () => {
          if (!triedFallback && fallback && fallback !== src) {
            triedFallback = true;
            drawImg(fallback);
          }
        };
        img.src = `logo/${encodeURIComponent(src)}`;
      };
      drawImg(primary);
    }
  } catch (e) {
    // ignore
  }

  // Debug pixel sample center
  // Debug pixel sample center (désactivé)
  // try { const d = ctx.getImageData(Math.floor(width/2), Math.floor(height/2), 1, 1).data; console.log('rgba', d[0],d[1],d[2],d[3]); } catch(e) {}
}

// Batch: dessine plusieurs polygones sur un même canvas/bbox
function drawTerritoryPolygonsBatch(payload) {
  if (!isDui) return;
  if (!payload || !payload.bbox || !Array.isArray(payload.polygons)) return;
  const width = payload.width || 1024;
  const height = payload.height || 1024;
  const safeW = Math.max(64, Number(width) || 1024);
  const safeH = Math.max(64, Number(height) || 1024);
  setCanvasSize(safeW, safeH);
  clearCanvas();

  try {
    const zone = (payload.zone || 'unknown');
    // Log réduit : seulement la première fois
    if (!window._loggedZones) window._loggedZones = {};
    if (!window._loggedZones[zone]) {
      // console.log(`[nvTerritory:UI] drawPolygons zone=${zone} size=${safeW}x${safeH} count=${Array.isArray(payload.polygons)?payload.polygons.length:0}`);
      window._loggedZones[zone] = true;
    }
  } catch (e) {}

  const minX = payload.bbox.minX, maxX = payload.bbox.maxX;
  const minY = payload.bbox.minY, maxY = payload.bbox.maxY;
  const scaleX = safeW / Math.max(0.0001, (maxX - minX));
  const scaleY = safeH / Math.max(0.0001, (maxY - minY));

  // Lecture paramètres logo globaux
  const logoCfg = payload.logo || {};
  const logoOpacity = Math.max(0, Math.min(1, Number(logoCfg.opacity ?? 0.95)));
  const logoSizeScale = Math.max(1, Math.min(10, Number(logoCfg.size ?? 5))); // 1..10
  // Mapping échelle 1..10 → min/max en % de la plus petite dimension
  const minPctBase = 0.06 + (logoSizeScale - 1) * (0.02 / 9); // 6%..8%
  const maxPctBase = 0.12 + (logoSizeScale - 1) * (0.10 / 9); // 12%..22%

  for (let k = 0; k < payload.polygons.length; k++) {
    const poly = payload.polygons[k];
    if (!poly || !Array.isArray(poly.points) || poly.points.length < 3) continue;

    const isControlled = (poly.controlled === true || poly.controlled === 1 || poly.controlled === 'true');
    const fill = poly.fill || (isControlled ? { r: 220, g: 30, b: 30, a: 0.35 } : { r: 80, g: 180, b: 255, a: 0.35 });
    const stroke = poly.stroke || { r: 255, g: 255, b: 255, a: 0.9, width: 2 };

    ctx.save();
    ctx.imageSmoothingEnabled = true;
    ctx.imageSmoothingQuality = 'high';
    ctx.beginPath();
    const canvasPts = [];
    for (let i = 0; i < poly.points.length; i++) {
      const p = poly.points[i];
      const x = (p.x - minX) * scaleX;
      const y = (maxY - p.y) * scaleY; // invert Y to match map
      canvasPts.push({x, y});
      if (i === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    }
    ctx.closePath();
    ctx.fillStyle = `rgba(${fill.r}, ${fill.g}, ${fill.b}, ${fill.a})`;
    ctx.fill();
    ctx.lineWidth = stroke.width;
    ctx.strokeStyle = `rgba(${stroke.r}, ${stroke.g}, ${stroke.b}, ${stroke.a})`;
    ctx.stroke();
    ctx.restore();

    // Logo centré
    try {
      const canShow = (poly.showLogo !== false);
      const primary = poly.crewLogoRaw || poly.crewLogo; // priorité au nom exact
      const fallback = poly.crewLogoRaw ? (poly.crewLogo || null) : null;
      if (canShow && isControlled && primary) {
        let area = 0, cx = 0, cy = 0;
        for (let i = 0, j = canvasPts.length - 1; i < canvasPts.length; j = i++) {
          const p0 = canvasPts[j], p1 = canvasPts[i];
          const f = (p0.x * p1.y - p1.x * p0.y);
          area += f; cx += (p0.x + p1.x) * f; cy += (p0.y + p1.y) * f;
        }
        area *= 0.5;
        let centerX = safeW / 2, centerY = safeH / 2;
        if (Math.abs(area) > 1e-3) { cx = cx / (6 * area); cy = cy / (6 * area); centerX = cx; centerY = cy; }
        const drawImg = (src) => {
          const img = new Image();
          let triedFallback = false;
          img.onload = () => {
            // Taille logo proportionnelle à l'aire du polygone, bornée par config
            const bboxArea = Math.max(1, safeW * safeH);
            const polyAreaAbs = Math.abs(area);
            const areaRatio = Math.min(1, Math.max(0.02, polyAreaAbs / bboxArea));
            const base = Math.min(safeW, safeH);
            const minPct = minPctBase; // dépend de LogoSize
            const maxPct = maxPctBase;
            const scaled = base * (minPct + (maxPct - minPct) * areaRatio);
            const size = Math.round(Math.max(base * minPct, Math.min(base * maxPct, scaled)));
            const drawW = size, drawH = size;
            const dx = Math.floor(centerX - drawW / 2);
            const dy = Math.floor(centerY - drawH / 2);
            ctx.save(); ctx.globalAlpha = logoOpacity; ctx.drawImage(img, dx, dy, drawW, drawH); ctx.restore();
          };
          img.onerror = () => {
            if (!triedFallback && fallback && fallback !== src) {
              triedFallback = true; drawImg(fallback);
            }
          };
          img.src = `logo/${encodeURIComponent(src)}`;
        };
        drawImg(primary);
      }
    } catch (e) {}
  }
}

function onMessage(event) {
  try {
    const data = typeof event.data === 'string' ? JSON.parse(event.data) : event.data;
    if (!data || !data.action) return;
    if (data.action === 'drawPolygon') {
      drawTerritoryPolygon(data);
      if (typeof GetParentResourceName !== 'undefined') {
        try {
          fetch(`https://${GetParentResourceName()}/uiLog`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=utf-8' },
            body: JSON.stringify({ msg: `drawPolygon ${data.name} ${canvas.width}x${canvas.height}` })
          });
        } catch (e) {}
      }
    } else if (data.action === 'drawPolygons') {
      drawTerritoryPolygonsBatch(data);
      if (typeof GetParentResourceName !== 'undefined') {
        try {
          fetch(`https://${GetParentResourceName()}/uiLog`, {
            method: 'POST', headers: { 'Content-Type': 'application/json; charset=utf-8' },
            body: JSON.stringify({ msg: `drawPolygons batch ${canvas.width}x${canvas.height} count=${Array.isArray(data.polygons)?data.polygons.length:0}` })
          });
        } catch (e) {}
      }
    } else if (data.action === 'console' && data.message) {
      // Logs réduits : seulement les messages importants
      if (data.message.includes('BATCH SEND') || data.message.includes('REFRESH RESEND') || data.message.includes('RECREATE')) {
        // console.log('[nvTerritory:UI]', data.message);
        if (typeof GetParentResourceName !== 'undefined') {
          try {
            fetch(`https://${GetParentResourceName()}/uiLog`, {
              method: 'POST', headers: { 'Content-Type': 'application/json; charset=utf-8' },
              body: JSON.stringify({ msg: String(data.message) })
            });
          } catch (e) {}
        }
      }
    } else if (data.action === 'ping') {
      // console.log('[nvTerritory:UI] ping received');
    } else if (data.action === 'tooltip') {
      const el = document.getElementById('territory-tooltip');
      if (data.show && (data.name || data.description)) {
        const id = data.id || '';
        // Fréquentation mapping couleurs/labels
        const freqKey = String(data.frequentation || '').toLowerCase();
        let freqClass = 'normal';
        let freqLabel = (data.labels && data.labels.levelNormal) || 'Normal';
        if (freqKey === 'low') { freqClass = 'low'; freqLabel = (data.labels && data.labels.levelLow) || 'Faible'; }
        else if (freqKey === 'high') { freqClass = 'high'; freqLabel = (data.labels && data.labels.levelHigh) || 'Forte'; }

        // Concurrence: selon seuils reçus et compteur
        let concClass = 'normal';
        let concLabel = (data.labels && data.labels.levelNormal) || 'Normal';
        const thresholds = data.competitionThresholds || { low: 1, normal: 4 };
        const count = (typeof data.competition === 'number') ? data.competition : null;
        if (count !== null) {
          if (count <= thresholds.low) { concClass = 'low'; concLabel = (data.labels && data.labels.levelLow) || 'Faible'; }
          else if (count <= thresholds.normal) { concClass = 'normal'; concLabel = (data.labels && data.labels.levelNormal) || 'Normal'; }
          else { concClass = 'high'; concLabel = (data.labels && data.labels.levelHigh) || 'Forte'; }
        } else {
          concClass = 'normal'; concLabel = 'Normal';
        }

        const isControlled = data.isControlled === true;
        let concExtra = '';
        let concText = concLabel;
        if (!isControlled) {
          concClass = 'low';
          concText = (data.labels && data.labels.none) || 'Aucune';
        } else {
          if (count !== null && concClass !== 'low') {
            concExtra = ` <span style="opacity:.8">(${count})</span>`;
          }
        }

        // Préparer l'affichage du crew leader et devise
        let crewLeaderHtml = '';
        if (isControlled && data.crewName && data.crewDevise) {
          crewLeaderHtml = `<div class="crew-leader"><b>${(data.labels && data.labels.crewLeader) || 'Crew Leader'}</b> : ${data.crewName} - ${data.crewDevise}</div>`;
        } else if (isControlled && data.crewName) {
          crewLeaderHtml = `<div class="crew-leader"><b>${(data.labels && data.labels.crewLeader) || 'Crew Leader'}</b> : ${data.crewName}</div>`;
        }

        el.innerHTML = `
          <div class="title">${data.name || ''}</div>
          ${id ? `<img class="photo" src="territories/${id}.webp" alt="${data.name || ''}" />` : ''}
          <div class="desc">${data.description || ''}</div>
          ${crewLeaderHtml}
          <div class="meta">
            <div class="row"><b>${(data.labels && data.labels.frequentation) || 'Fréquentation'}</b> : <span class="badge ${freqClass}">${freqLabel}</span></div>
            <div class="row"><b>${(data.labels && data.labels.competition) || 'Concurrence'}</b> : <span class="badge ${concClass}">${concText}</span>${concExtra}</div>
          </div>
        `;
        el.style.display = 'block';
      } else {
        el.style.display = 'none';
      }
    } else {
      // console.log('[nvTerritory:UI] unknown action', data.action);
    }
  } catch (e) {
    // ignore
  }
}

window.addEventListener('message', onMessage);
document.addEventListener('message', onMessage);
window.onmessage = onMessage;

// Pas d'affichage de test en production

// ============================
// Color Picker (Crew) – NUI côté client
// ============================
(function initColorPicker(){
  const picker = document.getElementById('color-picker');
  if (!picker) return;
  const inputColor = document.getElementById('cp-color');
  const inputHex = document.getElementById('cp-hex');
  const btnOk = document.getElementById('cp-ok');

  function toHex(v){
    const s = String(v||'').trim();
    if (!s) return '';
    let h = s.toUpperCase();
    if (h[0] !== '#') h = '#' + h;
    if (h.length === 4) {
      // #RGB → #RRGGBB
      h = '#' + h[1]+h[1] + h[2]+h[2] + h[3]+h[3];
    }
    if (/^#[0-9A-F]{6}$/.test(h)) return h;
    return '';
  }

  inputColor.addEventListener('input', () => {
    inputHex.value = inputColor.value.toUpperCase();
  });
  inputHex.addEventListener('input', () => {
    const h = toHex(inputHex.value);
    if (h) inputColor.value = h;
  });

  btnOk.addEventListener('click', () => {
    const hex = toHex(inputHex.value || inputColor.value) || '#50B4FF';
    if (typeof GetParentResourceName !== 'undefined') {
      fetch(`https://${GetParentResourceName()}/crewColorPicked`, {
        method: 'POST', headers: { 'Content-Type': 'application/json; charset=utf-8' },
        body: JSON.stringify({ hex })
      });
      // Demande explicite de relâcher la souris côté client Lua
      fetch(`https://${GetParentResourceName()}/crewReleaseFocus`, {
        method: 'POST', headers: { 'Content-Type': 'application/json; charset=utf-8' },
        body: JSON.stringify({})
      });
    }
    // Masquer après validation (le focus est libéré côté client LUA)
    picker.style.display = 'none';
  });

  window.addEventListener('message', (e) => {
    const d = typeof e.data === 'string' ? JSON.parse(e.data) : e.data;
    if (!d || !d.action) return;
    if (d.action === 'showColorPicker') {
      picker.style.display = 'block';
      const start = toHex(d.initial || '#50B4FF') || '#50B4FF';
      inputColor.value = start; inputHex.value = start;
    } else if (d.action === 'hideColorPicker') {
      picker.style.display = 'none';
    }
  });
})();