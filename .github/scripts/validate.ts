/**
 * Validates the KillerCoda tutorials of the repository.
 *
 * Usage:
 *   node .github/scripts/validate.ts                validate the whole repository
 *   node .github/scripts/validate.ts --changed REF  validate only what changed since REF
 *
 * Checks:
 *   - every structure.json / index.json is valid JSON
 *   - every path listed in a structure.json exists and has its own structure.json or index.json
 *   - every file referenced by an index.json exists (steps, scripts, assets)
 *   - every Taskfile.yaml is valid YAML, accepted by `task --list-all`,
 *     and each of its shell commands passes `bash -n`
 *   - every shell script passes `bash -n`
 *
 * Runs directly on Node.js 24 (type stripping), no build step.
 */
import { execFileSync, spawnSync } from 'node:child_process';
import { existsSync, readFileSync, statSync } from 'node:fs';
import { dirname, join, relative, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parse as parseYaml } from 'yaml';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..');
const errors = new Set<string>();

function fail(file: string, message: string): void {
  errors.add(`${relative(root, file)}: ${message}`);
}

function git(...args: string[]): string[] {
  const out = execFileSync('git', args, { cwd: root, encoding: 'utf8' });
  return out.split('\n').filter(Boolean).map(line => join(root, line));
}

const tracked = (...patterns: string[]): string[] => git('ls-files', ...patterns);

function isInside(file: string, directory: string): boolean {
  return file.startsWith(directory + sep);
}

function isFile(path: string): boolean {
  return existsSync(path) && statSync(path).isFile();
}

function readJson(file: string): unknown {
  try {
    return JSON.parse(readFileSync(file, 'utf8'));
  } catch (error) {
    fail(file, `invalid JSON: ${(error as Error).message}`);
    return undefined;
  }
}

// ---- structure.json ----------------------------------------------------------

interface Structure {
  items?: { path?: string }[];
}

function checkStructure(file: string): void {
  const structure = readJson(file) as Structure | undefined;
  for (const item of structure?.items ?? []) {
    const target = join(dirname(file), item.path ?? '');
    if (!existsSync(target) || !statSync(target).isDirectory()) {
      fail(file, `item path '${item.path}' is not a directory`);
    } else if (!isFile(join(target, 'structure.json')) && !isFile(join(target, 'index.json'))) {
      fail(file, `item '${item.path}' has neither structure.json nor index.json`);
    }
  }
}

// ---- index.json --------------------------------------------------------------

interface Index {
  details?: {
    assets?: Record<string, { file?: string }[]>;
    [section: string]: unknown;
  };
}

// Keys of the intro, steps and finish entries that point to a file of the tutorial
const fileKeys = new Set(['text', 'foreground', 'background', 'verify', 'setup']);

function* referencedFiles(node: unknown): Generator<string> {
  if (Array.isArray(node)) {
    for (const value of node) yield* referencedFiles(value);
  } else if (node && typeof node === 'object') {
    for (const [key, value] of Object.entries(node)) {
      if (fileKeys.has(key) && typeof value === 'string') yield value;
      else yield* referencedFiles(value);
    }
  }
}

function checkIndex(file: string): void {
  const index = readJson(file) as Index | undefined;
  if (!index?.details) return;
  const { assets = {}, ...sections } = index.details;
  for (const ref of referencedFiles(sections)) {
    if (!isFile(join(dirname(file), ref))) fail(file, `missing file '${ref}'`);
  }
  for (const [host, entries] of Object.entries(assets)) {
    for (const { file: ref = '' } of entries) {
      if (!existsSync(join(dirname(file), 'assets', ref))) fail(file, `missing asset '${ref}' for ${host}`);
    }
  }
}

// ---- Taskfile.yaml and shell scripts -----------------------------------------

function bashSyntax(source: string): string | undefined {
  const result = spawnSync('bash', ['-n'], { input: source, encoding: 'utf8' });
  return result.status === 0 ? undefined : result.stderr.trim();
}

interface Taskfile {
  tasks?: Record<string, { cmds?: unknown[] } | null>;
}

function checkTaskfile(file: string): void {
  let taskfile: Taskfile;
  try {
    taskfile = parseYaml(readFileSync(file, 'utf8')) as Taskfile;
  } catch (error) {
    fail(file, `invalid YAML: ${(error as Error).message}`);
    return;
  }
  const listing = spawnSync('task', ['--taskfile', file, '--list-all'], { encoding: 'utf8' });
  if (listing.status !== 0) fail(file, `task rejected the file: ${listing.stderr.trim()}`);

  for (const [name, spec] of Object.entries(taskfile.tasks ?? {})) {
    for (const cmd of spec?.cmds ?? []) {
      if (typeof cmd !== 'string') continue;
      // Task templates ({{.VAR}}) are not shell syntax: replace them before parsing
      const problem = bashSyntax(cmd.replace(/\{\{.*?\}\}/gs, 'X'));
      if (problem) fail(file, `task '${name}': ${problem}`);
    }
  }
}

function checkShell(file: string): void {
  const problem = bashSyntax(readFileSync(file, 'utf8'));
  if (problem) fail(file, problem);
}

// ---- main --------------------------------------------------------------------

let structures = tracked('**/structure.json', 'structure.json');
let indexes = tracked('**/index.json');
let taskfiles = tracked('**/Taskfile.yaml');
let scripts = tracked('**/*.sh');

const [flag, base] = process.argv.slice(2);
if (flag === '--changed' && base) {
  // Pull request mode: only validate what the pull request touches
  const changed = git('diff', '--name-only', '--diff-filter=d', `${base}...HEAD`);
  // A change to the pipeline itself validates every tutorial
  const pipeline = changed.some(file => isInside(file, join(root, '.github')));
  const tutorials = indexes
    .map(index => dirname(index))
    .filter(directory => pipeline || changed.some(file => isInside(file, directory)));
  const inTutorials = (file: string): boolean => tutorials.some(directory => isInside(file, directory));
  structures = structures.filter(file => pipeline || changed.includes(file));
  indexes = indexes.filter(file => tutorials.includes(dirname(file)));
  taskfiles = taskfiles.filter(inTutorials);
  scripts = scripts.filter(inTutorials);
  console.log(`Validating ${tutorials.length} tutorial(s) and ${structures.length} structure file(s)`);
}

structures.forEach(checkStructure);
indexes.forEach(checkIndex);
taskfiles.forEach(checkTaskfile);
scripts.forEach(checkShell);

for (const message of [...errors].sort()) console.log(`::error::${message}`);
console.log(`${errors.size} problem(s) found`);
process.exit(errors.size ? 1 : 0);
