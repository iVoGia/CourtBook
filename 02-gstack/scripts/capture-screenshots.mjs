#!/usr/bin/env node
/** Capture RestoDesk screenshots for presentation */
import { chromium } from 'playwright';
import { mkdir } from 'fs/promises';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const outDir = join(__dirname, '..', 'presentation', 'screenshots');
const base = 'http://localhost:5173';

const shots = [
  { path: '/', file: '01-dashboard.png', viewport: { width: 1280, height: 800 } },
  { path: '/menu?table=1', file: '02-feature.png', viewport: { width: 1280, height: 900 } },
  { path: '/kitchen', file: '03-result.png', viewport: { width: 1280, height: 800 } },
];

await mkdir(outDir, { recursive: true });
const browser = await chromium.launch();
const page = await browser.newPage();

for (const shot of shots) {
  await page.setViewportSize(shot.viewport);
  await page.goto(`${base}${shot.path}`, { waitUntil: 'networkidle' });
  await page.waitForTimeout(800);
  await page.screenshot({ path: join(outDir, shot.file), fullPage: false });
  console.log(`Saved ${shot.file}`);
}

await browser.close();
console.log('Done.');
