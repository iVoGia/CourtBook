import vi from './vi.json';

type Dict = Record<string, unknown>;

const dictionaries: Record<string, Dict> = { vi };

let locale = 'vi';

function getNested(obj: Dict, key: string): string | undefined {
  const parts = key.split('.');
  let current: unknown = obj;
  for (const part of parts) {
    if (current == null || typeof current !== 'object') return undefined;
    current = (current as Dict)[part];
  }
  return typeof current === 'string' ? current : undefined;
}

function interpolate(text: string, params?: Record<string, string | number>) {
  if (!params) return text;
  return text.replace(/\{(\w+)\}/g, (_, k: string) =>
    params[k] !== undefined ? String(params[k]) : `{${k}}`
  );
}

export function setLocale(next: string) {
  if (dictionaries[next]) locale = next;
}

export function t(key: string, params?: Record<string, string | number>): string {
  const text = getNested(dictionaries[locale], key);
  if (!text) return key;
  return interpolate(text, params);
}

export function useT() {
  return { t, locale };
}
