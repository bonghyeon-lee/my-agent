/* eslint-disable */
// @ts-nocheck
(global as any).unknown = () => ({});

import * as srcSchema from '../../../../src/lib/db/schema';
import * as distSchema from '../../../../drizzle/schema';

function getTables(schema: any) {
  const tables: Record<string, string[]> = {};
  for (const [key, value] of Object.entries(schema)) {
    if (value && typeof value === 'object') {
      const cols = Object.keys(value).filter(
        (k) =>
          k !== '_' &&
          k !== '$inferSelect' &&
          k !== '$inferInsert' &&
          typeof (value as any)[k] === 'object' &&
          (value as any)[k] !== null &&
          ('name' in (value as any)[k] || 'config' in (value as any)[k])
      );
      if (cols.length > 0) {
        tables[key] = cols.sort();
      }
    }
  }
  return tables;
}

const srcTables = getTables(srcSchema);
const distTables = getTables(distSchema);

const allTableNames = new Set([...Object.keys(srcTables), ...Object.keys(distTables)]);
let hasDiff = false;

for (const tableName of allTableNames) {
  const srcCols = srcTables[tableName];
  const distCols = distTables[tableName];

  if (!srcCols) {
    console.log(`+ Table ${tableName} exists in DB (drizzle/) but not in src`);
    hasDiff = true;
  } else if (!distCols) {
    console.log(`- Table ${tableName} exists in src but not in DB (drizzle/)`);
    hasDiff = true;
  } else {
    const srcColSet = new Set(srcCols);
    const distColSet = new Set(distCols);
    for (const distCol of distCols) {
      if (!srcColSet.has(distCol)) {
        console.log(`+ Column ${tableName}.${distCol} exists in DB (drizzle/) but not in src`);
        hasDiff = true;
      }
    }
    for (const srcCol of srcCols) {
      if (!distColSet.has(srcCol)) {
        console.log(`- Column ${tableName}.${srcCol} exists in src but not in DB (drizzle/)`);
        hasDiff = true;
      }
    }
  }
}

if (!hasDiff) {
  console.log('No missing or extra tables/columns found between DB and src schema!');
}
