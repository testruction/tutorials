/**
 * Lists the container images changed relative to a base ref, as a JSON matrix
 * for the CI workflows. Adapted from alithya-oss/containers
 * (scripts/ci/list-changed-images.js).
 *
 * An image is a `containers/<name>/` directory of a tutorial that contains a
 * Dockerfile, e.g. backstage/00-argo-workflows-playground/containers/backstage.
 *
 * Rules:
 *   - a change under an image directory selects that image;
 *   - a change to a global path (this script, .hadolint.yaml, the image
 *     workflows) selects every image;
 *   - an unknown base (first push, force-push) selects every image.
 *
 * Outputs, written to $GITHUB_OUTPUT when set and always printed:
 *   images       JSON array of image directories
 *   has_changes  "true" | "false"
 *
 * Usage:
 *   BASE_REF=origin/main node .github/scripts/list-changed-images.ts
 */
import { execFileSync } from 'node:child_process';
import { appendFileSync } from 'node:fs';
import { dirname } from 'node:path';

const GLOBAL_PATTERNS = [
  /^\.github\/scripts\/list-changed-images\.ts$/,
  /^\.github\/workflows\/(hadolint|pr-build)\.ya?ml$/,
  /^\.hadolint\.ya?ml$/,
];

const git = (...args: string[]): string => execFileSync('git', args, { encoding: 'utf8' }).trim();

function images(): string[] {
  return git('ls-files', '*/containers/*/Dockerfile')
    .split('\n')
    .filter(file => /\/containers\/[^/]+\/Dockerfile$/.test(file))
    .map(file => dirname(file))
    .sort();
}

/** Files changed by this branch, or undefined when the base cannot be resolved. */
function changedFiles(baseRef: string): string[] | undefined {
  if (!baseRef || /^0+$/.test(baseRef)) return undefined;
  try {
    git('rev-parse', '--verify', `${baseRef}^{commit}`);
  } catch {
    return undefined;
  }
  // Merge base: only what this branch changed, not what landed on the base since
  const base = git('merge-base', baseRef, 'HEAD');
  return git('diff', '--name-only', base, 'HEAD').split('\n').filter(Boolean);
}

const all = images();
const files = changedFiles(process.env.BASE_REF ?? 'origin/main');
const selected =
  files === undefined || files.some(file => GLOBAL_PATTERNS.some(pattern => pattern.test(file)))
    ? all
    : all.filter(image => files.some(file => file.startsWith(`${image}/`)));

const lines = [`images=${JSON.stringify(selected)}`, `has_changes=${selected.length > 0}`];
if (process.env.GITHUB_OUTPUT) appendFileSync(process.env.GITHUB_OUTPUT, `${lines.join('\n')}\n`);
console.log(lines.join('\n'));
