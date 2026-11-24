import { existsSync, readFileSync, readdirSync } from "node:fs";
import { basename, dirname, join, relative } from "node:path";
import { fileURLToPath } from "node:url";
import { parseDocument } from "yaml";

const root = fileURLToPath(new URL("..", import.meta.url));
const SKIP_DIRS = new Set(["_", "node_modules", ".venv", "__pycache__", "output"]);

function* skillFiles(dir) {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      if (SKIP_DIRS.has(entry.name)) continue;
      yield* skillFiles(join(dir, entry.name));
    } else if (entry.name === "SKILL.md") {
      yield join(dir, entry.name);
    }
  }
}

const failures = [];
const seenNames = new Map();
let checkedCount = 0;

for (const file of skillFiles(join(root, "skills"))) {
  checkedCount++;
  const rel = relative(root, file).replace(/\\/g, "/");
  const folderName = basename(dirname(file));
  const raw = readFileSync(file, "utf8");
  const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---/);

  if (!match) {
    failures.push(`${rel}: missing YAML frontmatter block`);
    continue;
  }

  const doc = parseDocument(match[1], { strict: true, uniqueKeys: true });
  if (doc.errors.length > 0) {
    failures.push(`${rel}: invalid YAML (${doc.errors[0].message.split("\n")[0]})`);
    continue;
  }

  const data = doc.toJS();
  for (const key of ["name", "description"]) {
    if (typeof data?.[key] !== "string" || data[key].trim() === "") {
      failures.push(`${rel}: missing or empty '${key}'`);
    }
  }

  if (typeof data?.name === "string" && data.name.trim() !== "") {
    if (data.name !== folderName) {
      failures.push(`${rel}: frontmatter name '${data.name}' does not match folder '${folderName}'`);
    }
    if (!rel.startsWith("skills/deprecated/")) {
      const prev = seenNames.get(data.name);
      if (prev) {
        failures.push(`${rel}: duplicate skill name '${data.name}' (already defined at ${prev})`);
      } else {
        seenNames.set(data.name, rel);
      }
    }
  }
}

const pluginPath = join(root, ".claude-plugin", "plugin.json");
if (!existsSync(pluginPath)) {
  failures.push(".claude-plugin/plugin.json: file not found");
} else {
  const plugin = JSON.parse(readFileSync(pluginPath, "utf8"));
  if (!Array.isArray(plugin.skills) || plugin.skills.length === 0) {
    failures.push(".claude-plugin/plugin.json: 'skills' must be a non-empty array");
  } else {
    for (const skillRef of plugin.skills) {
      const normalized = skillRef.replace(/^\.\//, "");
      if (
        normalized.startsWith("skills/external/") ||
        normalized.startsWith("skills/in-progress/") ||
        normalized.startsWith("skills/deprecated/")
      ) {
        failures.push(`.claude-plugin/plugin.json: '${skillRef}' must not promote external, in-progress, or deprecated skills`);
      }
      const skillMd = join(root, normalized, "SKILL.md");
      if (!existsSync(skillMd)) {
        failures.push(`.claude-plugin/plugin.json: missing SKILL.md for '${skillRef}'`);
      }
    }
  }
}

const marketplacePath = join(root, ".claude-plugin", "marketplace.json");
if (!existsSync(marketplacePath)) {
  failures.push(".claude-plugin/marketplace.json: file not found");
} else {
  JSON.parse(readFileSync(marketplacePath, "utf8"));
}

if (failures.length > 0) {
  console.error(failures.join("\n"));
  console.error(`\n${failures.length} validation error(s) found.`);
  process.exit(1);
}

console.log(`OK: validated ${checkedCount} SKILL.md file(s) and Claude plugin manifests.`);
